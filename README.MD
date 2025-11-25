⚡ Zynq-7020 TCP Performance Server + AXI DMA High-Speed Writer
~390 MB/s DDR Write Throughput · lwIP RAW TCP Perf Server · 1 Gbit/s iperf
📸 Block Design
<p align="center"> <img src="https://github.com/user-attachments/assets/4d9dc7db-beca-43ff-a09d-b0afaa13319d" width="800" /> </p> <p align="center"> <img src="https://github.com/user-attachments/assets/f43510b4-618e-4216-a0a8-e6bc26982d3d" width="420" /> <img src="https://github.com/user-attachments/assets/b3a71f4e-2e61-49ee-b58c-ded47299bd49" width="420" /> </p>

This project implements a high-performance TCP performance server on the Zynq-7020, combining:

lwIP RAW TCP perf server (iperf-compatible)

AXI DMA S2MM writing directly to DDR3

PL burst generator (64-bit AXI-Stream)

GPIO-based start/end cycle timing

TTC timer profiling

The design achieves ~390 MB/s sustained DDR write throughput at FCLK0 = 142.857 MHz, using a 1,048,576-beat × 64-bit streaming burst.

🔧 System Overview

The ARM Cortex-A9 (PS) handles:

TCP/IP networking

iperf traffic & statistics

DMA configuration

Timing capture & reporting

The Programmable Logic (PL):

Generates 64-bit AXI stream data

Streams 1M beats per DMA burst

Captures cycle-accurate timestamps

Drives AXI DMA → DDR3 via HP0

⭐ Key Capabilities

TCP Perf Server on port 5001

940–950 Mbit/s TCP throughput (line-rate)

~390 MB/s DDR write speed via DMA

Precise PL cycle counter for timing

TTC timer for cross-verification

64-bit AXI Stream for maximum throughput

🧩 Block Design Summary
Peripheral	Description
Zynq PS (Cortex-A9)	Runs lwIP RAW TCP perf server
AXI DMA (S2MM)	High-speed DDR streaming
FCLK0 = 142.857 MHz	Drives PL generator & DMA
AXI HP0 Port	High-bandwidth DDR3 access
TTC Timer	Tick counter for profiling
AXI GPIO (Trigger / Start / End)	Handshake & timestamp transfer
PL AXI-Stream Generator	Sends 1M beats → DMA → DDR
Reset Controller	Syncs PS ↔ PL reset domains
🚀 Performance Summary
Metric	Measured Value
DDR3 Write Speed	≈ 390 MB/s
DMA Width	64-bit (8 bytes/beat)
Burst Size	1,048,576 beats (8 MB)
PL Clock (FCLK0)	142.857 MHz
TCP Throughput	~940 Mbit/s (iperf max)
CPU Usage	Low