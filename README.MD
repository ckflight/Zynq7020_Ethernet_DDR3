⚡ Zynq-7020 TCP Performance Server + AXI DMA High-Speed Writer
~390 MB/s DDR Write Throughput — lwIP RAW TCP Perf Server — 1Gbit/s iperf
📸 Block Design

(Insert BD screenshot here)
Example:
<img width="550" height="433" alt="Image" src="https://github.com/user-attachments/assets/f43510b4-618e-4216-a0a8-e6bc26982d3d" />
<img width="907" height="539" alt="Image" src="https://github.com/user-attachments/assets/4d9dc7db-beca-43ff-a09d-b0afaa13319d" />
<img width="472" height="438" alt="Image" src="https://github.com/user-attachments/assets/b3a71f4e-2e61-49ee-b58c-ded47299bd49" />

This project implements a high-performance TCP Perf Server on Zynq-7020, integrated with:

lwIP RAW TCP perf server (compatible with iperf)

AXI DMA S2MM high-speed writes to DDR3

Programmable Logic burst generator (64-bit AXI-Stream)

GPIO-based cycle timing measurement

TTC timer profiling

The system reaches ~390 MB/s sustained DDR write speed at FCLK0 = 142.857 MHz, using a 1,048,576-beat × 64-bit streaming burst.

🔧 System Overview

The ARM Cortex-A9 (PS) handles TCP/IP (lwIP), perf measurements, and DMA control.
The Programmable Logic (PL) continuously streams high-speed data into the AXI DMA, which writes directly into DDR3 over the HP port.

Key Capabilities

TCP Perf Server (iperf-compatible) on port 5001

Steady 940–950 Mbit/s TCP throughput (Gigabit line-rate)

~390 MB/s DDR throughput via AXI DMA

Full cycle-accurate profiling with PL counter + GPIO

TTC timer used for reference timing

64-bit AXI-Stream data path (8 bytes/beat)

🧩 Block Design Summary
Peripheral	Description
Zynq PS (Cortex-A9)	Runs lwIP RAW TCP perf server
AXI DMA (S2MM)	High-speed streaming to DDR
FCLK0 = 142.857 MHz	Drives PL data generator & DMA
AXI HP0 Port	High-bandwidth DDR3 access
TTC Timer	Tick measurement for profiling
AXI GPIO (Trigger/Start/End)	Start handshake + cycle timestamps
PL AXI-Stream Data Generator	Sends 1M beats → DMA → DDR
Reset Controller	Synchronizes PS-to-PL reset
🚀 Performance Summary
Metric	Measured Value
DDR3 Write Speed	≈ 390 MB/s
DMA Width	64-bit (8 bytes/beat)
Burst Size	1,048,576 beats → 8 MB total
PL Clock (FCLK0)	142.857 MHz
TCP Throughput	~940 Mbit/s (iperf max)
CPU Usage	Minimal