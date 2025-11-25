# ⚡ Zynq-7020 TCP Performance Server + AXI DMA High-Speed Writer

## 📸 Block Design

<img width="907" height="539" alt="Image" src="https://github.com/user-attachments/assets/4d9dc7db-beca-43ff-a09d-b0afaa13319d" />

<img width="550" height="433" alt="Image" src="https://github.com/user-attachments/assets/f43510b4-618e-4216-a0a8-e6bc26982d3d" />

<img width="472" height="438" alt="Image" src="https://github.com/user-attachments/assets/b3a71f4e-2e61-49ee-b58c-ded47299bd49" />

This project implements a high-performance TCP Perf Server on a Xilinx Zynq-7020.  
It integrates lwIP RAW TCP networking, AXI DMA high-speed DDR3 streaming, and a custom PL AXI-Stream burst generator — forming a complete high-throughput data pipeline.

The system reaches **~390 MB/s** sustained DDR write throughput at **FCLK0 = 142.857 MHz**, using a **1,048,576-beat × 64-bit AXI-Stream** burst.

---

## 🔧 System Overview

The system is centered around the dual-core ARM Cortex-A9, with peripherals connected via the Zynq PS–PL interfaces.  
It supports high-speed DMA data movement, lightweight TCP/IP using lwIP, GPIO-based timing, and TTC timer profiling.

The AXI DMA writes PL-generated 64-bit AXI-Stream data directly into DDR3 through the HP0 port.

### 🧩 Block Design Summary

 Peripheral  | Description
-------------|----------------------------------------------
 Zynq PS (Cortex-A9) | Runs lwIP RAW TCP perf server
 AXI DMA (S2MM) | High-speed streaming to DDR memory
 FCLK0 = 142.857 MHz | Drives PL data generator & DMA engine
 AXI HP0 Port | High-bandwidth DDR3 access for DMA
 TTC Timer | Tick-based profiling support
 AXI GPIO (Trigger/Start/End) | Start handshake & cycle timestamps
 PL AXI-Stream Generator | Sends 1M beats → DMA → DDR
 Reset Controller | Synchronizes PS-to-PL reset

---

## 🧠 Top-Level Integration (`top_module.vhd`)

The VHDL top module wraps the Vivado Zynq block design (`arm_design_wrapper`)  
and connects it to the FPGA I/O, AXI-Stream generator, and GPIO timing logic.

### Main Interfaces
- GPIO output → PL start-trigger for DMA  
- GPIO inputs → PL cycle-start and cycle-end timestamps  
- AXI-Stream (64-bit) → `S_AXIS_S2MM` for DMA  
- DDR3 interface → Full PS-managed DDR memory  
- FCLK0 → Clock source for PL DMA generator  
- Integrated LED logic for heartbeat & state debug  

---

## 🚀 Performance Summary

- **~390 MB/s** sustained DDR3 write throughput  
- **940–950 Mbit/s** TCP throughput (iperf line-rate)  
- **1,048,576 beats × 8 bytes = 8 MB** DMA burst  
- **Precise PL cycle counter** for timing measurements  
- **Parallel TTC timer profiling**  
- Full lwIP RAW mode: lightweight, high-performance, low-overhead  

---

## 📦 Features

- ✅ High-speed AXI DMA DDR streaming  
- ✅ Full lwIP RAW TCP perf server (iperf-compatible)  
- ✅ Custom PL AXI-Stream data generator  
- ✅ GPIO timing handshake (start/end cycles)  
- ✅ TTC timer-based reference timing  
- ✅ Fully synthesizable and tested on Zynq-7020 hardware  
- ✅ Clean software design using standalone C (no Linux required)  

---

## ⚙️ Tools & Requirements

- Vivado 2023.2 or newer  
- Vitis (for ARM firmware development)  
- Zynq-7020 board (e.g., ZedBoard, Zybo Z7-20, custom board)  
- Gigabit Ethernet connection  
- Optional ILA debug cores for AXI-Stream & DMA  

---

## 🧾 License

MIT License © 2025 — Cenk Keskin

---

This design demonstrates a complete high-throughput PS–PL integration flow using Zynq-7000:  
AXI DMA, DDR3, lwIP networking, and a custom 64-bit PL data generator — all combined into an efficient, compact, and high-performance embedded system.
