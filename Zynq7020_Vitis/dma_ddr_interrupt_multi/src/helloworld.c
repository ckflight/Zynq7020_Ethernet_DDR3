
#include <stdio.h>
#include "xparameters.h"
#include "platform.h"
#include "xil_printf.h"

#include "xaxidma.h"
#include "xscugic.h"
#include "xgpio.h"
#include "xil_cache.h"
#include "xil_exception.h"

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

#define DMA_S2MM_INTR_ID            (32 + XPAR_FABRIC_XAXIDMA_0_INTR)// IRQ_F2P[0] → GIC ID 61 on Zynq
#define XPAR_XAXIDMA_0_DEVICE_ID    0

#define DDR_BASE_ADDR               0x01000000
#define FCLK0_FREQ_HZ               125000000.0

#define TTC_CLK_HZ                  XPAR_XTTCPS_0_CLOCK_FREQ        // from xparameters.h   
#define TTC_PRESCALER               6                               // divide by 2^6+1 = 128 (i have checked with usleep)
#define TTC_CLK_PRESCALED           ((float)XPAR_XTTCPS_0_CLOCK_FREQ / (float)(1U << (TTC_PRESCALER+1)))

#define PRINT_DDR_CONTENT           0

const int burst_words       = 131072;//262144;//1048576; 
const int bytes_per_word    = 8;         // 64-bit
const int data_size         = burst_words * bytes_per_word;
const int data_address_size = burst_words;
int dma_print_increment     = 1;


XTtcPs Ttc;

XAxiDma  AxiDma;
XScuGic  Intc;

XGpio GpioTrigger;
XGpio GpioStart;
XGpio GpioEnd;

volatile int S2MM_Done = 0;
volatile int DMA_Error = 0;

uint16_t ttc_counter_start = 0;
uint16_t ttc_counter_end = 0;

#define USE_TEST_TTC        1
uint16_t ttc_test_counter1 = 0;
uint16_t ttc_test_counter2 = 0;

uint32_t gpio_counter_start = 0;
uint32_t gpio_counter_end = 0;

#define TOTAL_BURST     20
uint32_t burst_counter = 0;


void S2mmIsr(void *CallbackRef)
{
    u32 IrqStatus;
    int TimeOut;
    XAxiDma *AxiDmaInst = (XAxiDma *)CallbackRef;

    XAxiDma_IntrDisable(AxiDmaInst, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);

    IrqStatus = XAxiDma_IntrGetIrq(AxiDmaInst, XAXIDMA_DEVICE_TO_DMA);
    XAxiDma_IntrAckIrq(AxiDmaInst, IrqStatus, XAXIDMA_DEVICE_TO_DMA);

    if (!(IrqStatus & XAXIDMA_IRQ_ALL_MASK))
        return;

    if (IrqStatus & XAXIDMA_IRQ_ERROR_MASK) {
        xil_printf("DMA ERROR IRQ\r\n");
        DMA_Error = 1;

        XAxiDma_Reset(AxiDmaInst);
        TimeOut = 10000;
        while (TimeOut--) {
            if (XAxiDma_ResetIsDone(AxiDmaInst))
                break;
        }
        return;
    }

    if (IrqStatus & XAXIDMA_IRQ_IOC_MASK) {
        S2MM_Done = 1;
        ttc_counter_end = XTtcPs_GetCounterValue(&Ttc);
    }

    XAxiDma_IntrEnable(AxiDmaInst,
        (XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK),
        XAXIDMA_DEVICE_TO_DMA);
}

/* ===================== GIC INIT (XILINX STYLE) ===================== */

int InitInterruptSystem(void)
{
    XScuGic_Config *CfgPtr;
    int Status;

    CfgPtr = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);
    if (!CfgPtr) return XST_FAILURE;

    Status = XScuGic_CfgInitialize(&Intc, CfgPtr, CfgPtr->CpuBaseAddress);
    if (Status != XST_SUCCESS) return XST_FAILURE;

    XScuGic_SetPriorityTriggerType(&Intc, DMA_S2MM_INTR_ID, 0xA0, 0x3);

    Status = XScuGic_Connect(&Intc, DMA_S2MM_INTR_ID, (Xil_ExceptionHandler)S2mmIsr, &AxiDma);
    if (Status != XST_SUCCESS) return XST_FAILURE;

    XScuGic_Enable(&Intc, DMA_S2MM_INTR_ID);

    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
        (Xil_ExceptionHandler)XScuGic_InterruptHandler, &Intc);
    Xil_ExceptionEnable();

    return XST_SUCCESS;
}

/* ===================== DMA INIT (XILINX STYLE) ===================== */

int InitAxiDma(void)
{
    XAxiDma_Config *CfgPtr;
    int Status;

    CfgPtr = XAxiDma_LookupConfig(XPAR_XAXIDMA_0_DEVICE_ID);
    if (!CfgPtr) return XST_FAILURE;

    Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
    if (Status != XST_SUCCESS) return XST_FAILURE;

    if (XAxiDma_HasSg(&AxiDma)) return XST_FAILURE;

    XAxiDma_Reset(&AxiDma);
    while (!XAxiDma_ResetIsDone(&AxiDma));

    XAxiDma_IntrEnable(&AxiDma,
        (XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK),
        XAXIDMA_DEVICE_TO_DMA);

    return XST_SUCCESS;
}

/* ===================== GPIO INIT ===================== */

void InitGpio(void)
{
    XGpio_Initialize(&GpioTrigger, XPAR_AXI_GPIO_0_BASEADDR);
    XGpio_Initialize(&GpioStart,   XPAR_AXI_GPIO_1_BASEADDR);
    XGpio_Initialize(&GpioEnd,     XPAR_AXI_GPIO_2_BASEADDR);

    XGpio_SetDataDirection(&GpioTrigger, 1, 0x00);
    XGpio_SetDataDirection(&GpioStart,   1, 0xFFFFFFFF);
    XGpio_SetDataDirection(&GpioEnd,     1, 0xFFFFFFFF);

    XGpio_DiscreteWrite(&GpioTrigger, 1, 0x00);
}

/* ===================== MAIN ===================== */

void print_ddr_content(u32* ddr_address){

    /* DDR buffer where DMA writes */
    u32 *buf32 = ddr_address;
    
    #if PRINT_DDR_CONTENT
        xil_printf("DDR content before DMA:\r\n");
        for (int i = 0; i < data_address_size; i += dma_print_increment) {
            xil_printf("[%d] = 0x%08X\r\n", i, buf32[i]);
        }
    #endif
    
}

int VerifyDdrContent(u64 *buf, u32 word_count)
{
    u32 i;
    u32 error_count = 0;

    for (i = 0; i < word_count; i++) {
        u64 expected = (u64)i;

        if (buf[i] != expected) {
            if (error_count < 10) {
                xil_printf("DDR MISMATCH @ %u: got = 0x%08X%08X, exp = 0x%08X%08X\r\n",
                            i,
                            (u32)(buf[i] >> 32), (u32)buf[i],
                            (u32)(expected >> 32), (u32)expected);
            }
            error_count++;
        }
    }

    if (error_count == 0) {
        xil_printf("DDR VERIFY PASSED (%u x 64-bit words)\r\n", word_count);
        return XST_SUCCESS;
    } else {
        xil_printf("DDR VERIFY FAILED: %u errors\r\n", error_count);
        return XST_FAILURE;
    }
}

int InitTtc(void)
{
    int Status;
    XTtcPs_Config *Config;
    u32 Options;

    Config = XTtcPs_LookupConfig(XPAR_TTC0_BASEADDR);
    if (Config == NULL) {
        return XST_FAILURE;
    }

    Status = XTtcPs_CfgInitialize(&Ttc, Config, Config->BaseAddress);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /* Free-running mode, no interval, no waveform */
    Options = XTTCPS_OPTION_WAVE_DISABLE;
    XTtcPs_SetOptions(&Ttc, Options);

    /* Prescaler: divides TTC_CLK_HZ by 2^TTC_PRESCALER */
    XTtcPs_SetPrescaler(&Ttc, TTC_PRESCALER);

    XTtcPs_Start(&Ttc);

    return XST_SUCCESS;
}

int main(void)
{
    init_platform();

    if (InitTtc() != XST_SUCCESS) {
        xil_printf("TTC init failed!\r\n");
        while(1);
    }

    InitGpio();
    InitAxiDma();
    InitInterruptSystem();

    #if USE_TEST_TTC
    ttc_test_counter1 = XTtcPs_GetCounterValue(&Ttc);
    usleep(100);
    ttc_test_counter2 = XTtcPs_GetCounterValue(&Ttc);
    uint16_t delta_test_time = ttc_test_counter2 - ttc_test_counter1;

    float delta_test_sec = (float)delta_test_time / TTC_CLK_PRESCALED;
    xil_printf("Test Time 100 microsec \r\n");
    xil_printf("Test Time: %u \r\n", delta_test_time);
    xil_printf("Test Time sec: %u \r\n", (int)(delta_test_sec * 1000000.0));

    ttc_test_counter1 = XTtcPs_GetCounterValue(&Ttc);
    usleep(10000);
    ttc_test_counter2 = XTtcPs_GetCounterValue(&Ttc);
    delta_test_time = ttc_test_counter2 - ttc_test_counter1;

    delta_test_sec = (float)delta_test_time / TTC_CLK_PRESCALED;
    xil_printf("Test Time 10000 microsec \r\n");
    xil_printf("Test Time: %u \r\n", delta_test_time);
    xil_printf("Test Time sec: %u \r\n", (int)(delta_test_sec * 1000000.0));

    ttc_test_counter1 = XTtcPs_GetCounterValue(&Ttc);
    usleep(70000); // 128 divider max 75 ms
    ttc_test_counter2 = XTtcPs_GetCounterValue(&Ttc);
    delta_test_time = ttc_test_counter2 - ttc_test_counter1;

    delta_test_sec = (float)delta_test_time / TTC_CLK_PRESCALED;
    xil_printf("Test Time 70000 microsec \r\n");
    xil_printf("Test Time: %u \r\n", delta_test_time);
    xil_printf("Test Time sec: %u \r\n", (int)(delta_test_sec * 1000000.0));
    #endif

    while (1){

        // For testing purposes it will write to the same place everytime
        
        // Array poits to the ddr content it is not creating a 8MByte array.
        u8 *RxBuffer = (u8 *)DDR_BASE_ADDR;
        Xil_DCacheFlushRange((UINTPTR)RxBuffer, data_size);

        S2MM_Done = 0;
        DMA_Error = 0;
        
        ttc_counter_start = XTtcPs_GetCounterValue(&Ttc);

        XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)RxBuffer, data_size, XAXIDMA_DEVICE_TO_DMA);
        
        if(burst_counter <= TOTAL_BURST){
            xil_printf("Burst Counter: %u\r\n", burst_counter);
            XGpio_DiscreteWrite(&GpioTrigger, 1, 1);
            usleep(5);
            XGpio_DiscreteWrite(&GpioTrigger, 1, 0x00);    
        }
        else{
            // do not trigger new transfer
            XGpio_DiscreteWrite(&GpioTrigger, 1, 0x00);
        }
                
        while(!S2MM_Done && !DMA_Error);
        
        if(S2MM_Done){
            burst_counter++;
            xil_printf("DMA S2MM DONE\r\n");
        }
        else if(DMA_Error) {
            xil_printf("DMA FAILED\r\n");
        }

        Xil_DCacheInvalidateRange((UINTPTR)RxBuffer, data_size);
        VerifyDdrContent((u64 *)DDR_BASE_ADDR, burst_words);

        // Read pl counters to calculate write speed
        gpio_counter_start  = XGpio_DiscreteRead(&GpioStart, 1);
        gpio_counter_end    = XGpio_DiscreteRead(&GpioEnd,   1);
        int delta           = gpio_counter_end - gpio_counter_start;

        float delta_sec = delta / FCLK0_FREQ_HZ;
        int speed = (float)data_size / delta_sec;

        xil_printf("GPIO start = %u, end = %u, delta = %u\r\n", gpio_counter_start, gpio_counter_end, delta);
        xil_printf("delta_ms = %u,%u ms\r\n", (int)(delta_sec*1000.0), (((int)(delta_sec*1000000.0))%1000));
        xil_printf("speed = %ubps\r\n", speed);
        xil_printf("speed = %uMbps\r\n", speed/1000000);
        xil_printf("\r\n");

        uint16_t ttc_delta = ttc_counter_end - ttc_counter_start;
        float ttc_delta_sec = (float)ttc_delta / TTC_CLK_PRESCALED;

        int ttc_speed   = (float)data_size / ttc_delta_sec;

        xil_printf("TTC start = %u, end = %u, delta = %u\r\n", ttc_counter_start, ttc_counter_end, ttc_delta);
        xil_printf("TTC delta_ms = %u,%u ms\r\n", (int)(ttc_delta_sec*1000.0), (((int)(ttc_delta_sec*1000000.0))%1000));
        xil_printf("speed = %ubps\r\n", ttc_speed);
        xil_printf("speed = %uMbps\r\n", ttc_speed/1000000);
        xil_printf("\r\n");
        
        print_ddr_content((u32*)DDR_BASE_ADDR);
        
    }
}
