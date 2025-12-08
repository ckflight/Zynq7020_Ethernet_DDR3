/*
 * Minimal lwIP RAW TCP Server main() — for Zynq / MicroBlaze
 * Plus: AXI DMA + GPIO timing measurement for S2MM.
 */

#include <stdio.h>
#include "xparameters.h"
#include "netif/xadapter.h"
#include "platform.h"
#include "xil_printf.h"
#include "lwip/init.h"
#include "lwip/inet.h"
#include "platform_config.h"

#include "xaxidma.h"
#include "xil_cache.h"
#include "xgpio.h"

#include "xttcps.h"

/*
These settings affect ethernet speed!!!
===========================================================
1) DHCP Settings
-----------------------------------------------------------
lwip220_dhcp = True
lwip220_lwip_dhcp_does_acd_check = True

2) Memory Size
-----------------------------------------------------------
lwip220_mem_size = 524288

3) PBUF & Memory Pool Settings
-----------------------------------------------------------
lwip220_memp_n_pbuf      = 1024
lwip220_memp_n_tcp_seg  = 1024
lwip220_pbuf_pool_size = 16384

4) TCP Buffer Settings
-----------------------------------------------------------
lwip220_tcp_snd_buf = 65535
lwip220_tcp_wnd     = 65535

5) PHY DMA Descriptor Settings
-----------------------------------------------------------
lwip220_n_rx_descriptors = 512
lwip220_n_tx_descriptors = 512
*/

XTtcPs Ttc;
XTtcPs_Config *TtcConfig;

#define DEFAULT_IP_ADDRESS   "192.168.1.10"
#define DEFAULT_IP_MASK      "255.255.255.0"
#define DEFAULT_GW_ADDRESS   "192.168.1.1"

extern volatile int TcpFastTmrFlag;
extern volatile int TcpSlowTmrFlag;

#define GPIO_TRIGGER_DEVICE_ID   XPAR_AXI_GPIO_TRIGGER_DEVICE_ID  // 8-bit OUT
#define GPIO_START_DEVICE_ID     XPAR_AXI_GPIO_START_DEVICE_ID    // 32-bit IN
#define GPIO_END_DEVICE_ID       XPAR_AXI_GPIO_END_DEVICE_ID      // 32-bit IN

XAxiDma AxiDma;

XGpio GpioTrigger;   // PS -> PL (bit 0 is start trigger)
XGpio GpioStart;     // PL -> PS (start_time[31:0])
XGpio GpioEnd;       // PL -> PS (end_time[31:0])

#define FCLK0_FREQ_HZ       142857132.0

#define PRINT_DDR_CONTENT   0

void start_application(void);
void print_app_header(void);

struct netif server_netif;

// 420Mb/sec write speed 142MHz clock(150 is selected but calculated is 142 by Zynq) with 1048576 -> 1048576 * 8 = 8 MByte data
const int burst_words       = 1048576; //= 1048576 ; 
const int bytes_per_word    = 8;         // 64-bit
const int data_size         = burst_words * bytes_per_word;
const int data_address_size = burst_words;
int dma_print_increment     = 1;
u32 ticks = 0;

/* Simple IPv4 print helper */
static void print_ip(char *msg, ip_addr_t *ip)
{
    xil_printf("%s%d.%d.%d.%d\r\n", msg,
        ip4_addr1(ip), ip4_addr2(ip),
        ip4_addr3(ip), ip4_addr4(ip));
}

/* Assign static IP */
static void assign_default_ip(ip_addr_t *ip, ip_addr_t *mask, ip_addr_t *gw)
{
    inet_aton(DEFAULT_IP_ADDRESS, ip);
    inet_aton(DEFAULT_IP_MASK,    mask);
    inet_aton(DEFAULT_GW_ADDRESS, gw);

    xil_printf("Static IP configured.\r\n");
}

void init_ttc_timer()
{
    TtcConfig = XTtcPs_LookupConfig(XPAR_XTTCPS_0_BASEADDR);
    XTtcPs_CfgInitialize(&Ttc, TtcConfig, TtcConfig->BaseAddress);

    // Stop timer
    XTtcPs_Stop(&Ttc);

    // Use internal clock
    XTtcPs_SetPrescaler(&Ttc, 0);     // no prescale → full 111 MHz

    // Reset counter
    XTtcPs_ResetCounterValue(&Ttc);
}


/* -------- GPIO init: 1 OUT, 2 IN ---------- */
void init_gpios(void)
{
    int status;

    /* TRIGGER GPIO (PS → PL, 8-bit OUTPUT) */
    status = XGpio_Initialize(&GpioTrigger, XPAR_AXI_GPIO_0_BASEADDR);
    if (status != XST_SUCCESS) {
        xil_printf("ERROR: GpioTrigger init failed\r\n");
    }
    /* Channel 1 as output (0 = output) */
    XGpio_SetDataDirection(&GpioTrigger, 1, 0x00);
    /* Clear trigger */
    XGpio_DiscreteWrite(&GpioTrigger, 1, 0x00);

    /* START TIME GPIO (PL → PS, 32-bit INPUT) */
    status = XGpio_Initialize(&GpioStart, XPAR_AXI_GPIO_1_BASEADDR);
    if (status != XST_SUCCESS) {
        xil_printf("ERROR: GpioStart init failed\r\n");
    }
    XGpio_SetDataDirection(&GpioStart, 1, 0xFFFFFFFF);  // all bits input

    /* END TIME GPIO (PL → PS, 32-bit INPUT) */
    status = XGpio_Initialize(&GpioEnd, XPAR_AXI_GPIO_2_BASEADDR);
    if (status != XST_SUCCESS) {
        xil_printf("ERROR: GpioEnd init failed\r\n");
    }
    XGpio_SetDataDirection(&GpioEnd, 1, 0xFFFFFFFF);    // all bits input

    xil_printf("GPIOs initialized.\r\n");
}

/* -------- Simple S2MM transfer + wait -------- */
int dma_s2mm_start(u32 dst_addr, u32 length_bytes)
{
    int Status;

    /* 1) Flush destination region (not strictly needed for pure write,
          but harmless) */
    Xil_DCacheFlushRange(dst_addr, length_bytes);

	XTtcPs_ResetCounterValue(&Ttc);

    // Start timer
    XTtcPs_Start(&Ttc);

    /* 2) Start S2MM transfer */
    Status = XAxiDma_SimpleTransfer(&AxiDma, dst_addr, length_bytes, XAXIDMA_DEVICE_TO_DMA);
    if (Status != XST_SUCCESS) {
        xil_printf("XAxiDma_SimpleTransfer failed: %d\r\n", Status);
        return XST_FAILURE;
    }

    /* 3) Wait for completion */
    while (XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA));

	// Stop
    XTtcPs_Stop(&Ttc);
    ticks = XTtcPs_GetCounterValue(&Ttc);
		

    /* 4) Read status */
    u32 s2mm_status = XAxiDma_ReadReg(AxiDma.RegBase, XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET);
    xil_printf("S2MM_DMASR = 0x%08lx\r\n", s2mm_status);

    if (s2mm_status & XAXIDMA_ERR_ALL_MASK) {
        xil_printf("S2MM error!\r\n");
        XAxiDma_Reset(&AxiDma);
        return XST_FAILURE;
    }

    /* 5) Invalidate cache to see new data from DDR */
    Xil_DCacheInvalidateRange(dst_addr, length_bytes);

    return XST_SUCCESS;
}

void init_axi_dma(){
    
    XAxiDma_Config *Cfg = XAxiDma_LookupConfig(XPAR_XAXIDMA_0_BASEADDR);
    if (!Cfg) {
        xil_printf("No DMA config found!\r\n");
        return;
    }

    if (XAxiDma_CfgInitialize(&AxiDma, Cfg) != XST_SUCCESS) {
        xil_printf("DMA init failed\r\n");
        return;
    }

    if (XAxiDma_HasSg(&AxiDma)) {
        xil_printf("DMA is in SG mode, expected simple mode!\r\n");
        return;
    }
    
}


int main(void)
{
    struct netif *netif = &server_netif;
    unsigned char mac_address[] = { 0x00, 0x0a, 0x35, 0x00, 0x01, 0x02 };

    init_platform();
    init_gpios();
	init_ttc_timer();



    init_axi_dma();
    
    //print_ddr_content((u32*)0x01000000);
    
    /* ---------- Trigger PL data generator ---------- */
    // Working tested. s2mm does not start without it
    XGpio_DiscreteWrite(&GpioTrigger, 1, 0x01);   // set bit0 = 1
    xil_printf("GPIO start signal sent\r\n");

    /* ---------- Start DMA transfer ---------- */
    dma_s2mm_start(0x01000000, data_size);
    xil_printf("DMA S2MM DONE\r\n");

    //print_ddr_content((u32*)0x01000000);

	// Read pl counters to calculate write speed
	u32 start = XGpio_DiscreteRead(&GpioStart, 1);
	u32 end   = XGpio_DiscreteRead(&GpioEnd,   1);
	int delta = end - start;

    float delta_sec = delta / FCLK0_FREQ_HZ;
    int speed = (float)data_size / delta_sec;


	xil_printf("start = %u\r\n", start);
	xil_printf("end   = %u\r\n", end);
	xil_printf("delta = %u cycles\r\n", delta);
    xil_printf("delta_ms = %u,%u ms\r\n", (int)(delta_sec*1000.0), (((int)(delta_sec*1000000.0))%1000));
    xil_printf("speed = %ubps\r\n", speed);
    xil_printf("speed = %uMbps\r\n", speed/1000000);




    // Ethernet
    xil_printf("\r\n--- Minimal lwIP TCP Server ---\r\n");

    lwip_init();

    if (!xemac_add(netif, NULL, NULL, NULL,
                   mac_address, PLATFORM_EMAC_BASEADDR)) {
        xil_printf("Error adding network interface\r\n");
        return -1;
    }

    netif_set_default(netif);
    netif_set_up(netif);
    assign_default_ip(&netif->ip_addr, &netif->netmask, &netif->gw);

    xil_printf("Network Interface Ready:\r\n");
    print_ip("IP:      ", &netif->ip_addr);
    print_ip("MASK:    ", &netif->netmask);
    print_ip("GATEWAY: ", &netif->gw);

    print_app_header();
    start_application();
    xil_printf("Server started. Waiting for connections...\r\n");



    while (1) {
        if (TcpFastTmrFlag) {
            tcp_fasttmr();
            TcpFastTmrFlag = 0;
        }
        if (TcpSlowTmrFlag) {
            tcp_slowtmr();
            TcpSlowTmrFlag = 0;
        }
        xemacif_input(netif);
    }

    cleanup_platform();
    return 0;
}
