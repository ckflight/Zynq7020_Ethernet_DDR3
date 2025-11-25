vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xpm
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_22
vlib questa_lib/msim/processing_system7_vip_v1_0_24
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/axi_datamover_v5_1_37
vlib questa_lib/msim/axi_sg_v4_1_21
vlib questa_lib/msim/axi_dma_v7_1_37
vlib questa_lib/msim/proc_sys_reset_v5_0_17
vlib questa_lib/msim/smartconnect_v1_0
vlib questa_lib/msim/axi_register_slice_v2_1_36
vlib questa_lib/msim/axi_lite_ipif_v3_0_4
vlib questa_lib/msim/interrupt_control_v3_1_5
vlib questa_lib/msim/axi_gpio_v2_0_37
vlib questa_lib/msim/generic_baseblocks_v2_1_2
vlib questa_lib/msim/fifo_generator_v13_2_14
vlib questa_lib/msim/axi_data_fifo_v2_1_36
vlib questa_lib/msim/axi_protocol_converter_v2_1_37

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xpm questa_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_22 questa_lib/msim/axi_vip_v1_1_22
vmap processing_system7_vip_v1_0_24 questa_lib/msim/processing_system7_vip_v1_0_24
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap axi_datamover_v5_1_37 questa_lib/msim/axi_datamover_v5_1_37
vmap axi_sg_v4_1_21 questa_lib/msim/axi_sg_v4_1_21
vmap axi_dma_v7_1_37 questa_lib/msim/axi_dma_v7_1_37
vmap proc_sys_reset_v5_0_17 questa_lib/msim/proc_sys_reset_v5_0_17
vmap smartconnect_v1_0 questa_lib/msim/smartconnect_v1_0
vmap axi_register_slice_v2_1_36 questa_lib/msim/axi_register_slice_v2_1_36
vmap axi_lite_ipif_v3_0_4 questa_lib/msim/axi_lite_ipif_v3_0_4
vmap interrupt_control_v3_1_5 questa_lib/msim/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_37 questa_lib/msim/axi_gpio_v2_0_37
vmap generic_baseblocks_v2_1_2 questa_lib/msim/generic_baseblocks_v2_1_2
vmap fifo_generator_v13_2_14 questa_lib/msim/fifo_generator_v13_2_14
vmap axi_data_fifo_v2_1_36 questa_lib/msim/axi_data_fifo_v2_1_36
vmap axi_protocol_converter_v2_1_37 questa_lib/msim/axi_protocol_converter_v2_1_37

vlog -work xilinx_vip  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/2025.2/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"C:/Xilinx/2025.2/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/2025.2/Vivado/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/2025.2/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/2025.2/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_22  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/b16a/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_24  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_processing_system7_0_0/sim/arm_design_processing_system7_0_0.v" \

vcom -work axi_datamover_v5_1_37  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/d44a/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_21  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/b193/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_dma_v7_1_37  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/7f6a/hdl/axi_dma_v7_1_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/arm_design/ip/arm_design_axi_dma_0_1/sim/arm_design_axi_dma_0_1.vhd" \

vcom -work proc_sys_reset_v5_0_17  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/arm_design/ip/arm_design_rst_ps7_0_100M_0/sim/arm_design_rst_ps7_0_100M_0.vhd" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_1/sim/bd_75f8_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/0848/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_2/sim/bd_75f8_arinsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_3/sim/bd_75f8_rinsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_4/sim/bd_75f8_awinsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_5/sim/bd_75f8_winsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_6/sim/bd_75f8_binsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_7/sim/bd_75f8_aroutsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_8/sim/bd_75f8_routsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_9/sim/bd_75f8_awoutsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_10/sim/bd_75f8_woutsw_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_11/sim/bd_75f8_boutsw_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_12/sim/bd_75f8_arni_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_13/sim/bd_75f8_rni_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_14/sim/bd_75f8_awni_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_15/sim/bd_75f8_wni_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_16/sim/bd_75f8_bni_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/3d9a/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_17/sim/bd_75f8_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/7785/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_18/sim/bd_75f8_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/3051/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_19/sim/bd_75f8_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/852f/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_20/sim/bd_75f8_s00a2s_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_21/sim/bd_75f8_sarn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_22/sim/bd_75f8_srn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_23/sim/bd_75f8_sawn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_24/sim/bd_75f8_swn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_25/sim/bd_75f8_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/fca9/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_26/sim/bd_75f8_m00s2a_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_27/sim/bd_75f8_m00arn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_28/sim/bd_75f8_m00rn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_29/sim/bd_75f8_m00awn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_30/sim/bd_75f8_m00wn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_31/sim/bd_75f8_m00bn_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/e44a/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_32/sim/bd_75f8_m00e_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_33/sim/bd_75f8_m01s2a_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_34/sim/bd_75f8_m01arn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_35/sim/bd_75f8_m01rn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_36/sim/bd_75f8_m01awn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_37/sim/bd_75f8_m01wn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_38/sim/bd_75f8_m01bn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_39/sim/bd_75f8_m01e_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_40/sim/bd_75f8_m02s2a_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_41/sim/bd_75f8_m02arn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_42/sim/bd_75f8_m02rn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_43/sim/bd_75f8_m02awn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_44/sim/bd_75f8_m02wn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_45/sim/bd_75f8_m02bn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_46/sim/bd_75f8_m02e_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_47/sim/bd_75f8_m03s2a_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_48/sim/bd_75f8_m03arn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_49/sim/bd_75f8_m03rn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_50/sim/bd_75f8_m03awn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_51/sim/bd_75f8_m03wn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_52/sim/bd_75f8_m03bn_0.sv" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/ip/ip_53/sim/bd_75f8_m03e_0.sv" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/bd_0/sim/bd_75f8.v" \

vcom -work smartconnect_v1_0  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/cb42/hdl/sc_ultralite_v1_0_rfs.vhd" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/cb42/hdl/sc_ultralite_v1_0_rfs.sv" \

vlog -work axi_register_slice_v2_1_36  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/bc4b/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L smartconnect_v1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L xilinx_vip "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_smc_2/sim/arm_design_axi_smc_2.sv" \

vcom -work axi_lite_ipif_v3_0_4  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work interrupt_control_v3_1_5  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_37  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/0271/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/arm_design/ip/arm_design_axi_gpio_0_1/sim/arm_design_axi_gpio_0_1.vhd" \
"../../../bd/arm_design/ip/arm_design_axi_gpio_1_1/sim/arm_design_axi_gpio_1_1.vhd" \
"../../../bd/arm_design/ip/arm_design_axi_gpio_2_0/sim/arm_design_axi_gpio_2_0.vhd" \

vlog -work generic_baseblocks_v2_1_2  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_14  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/d654/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_14  -93  \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/d654/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_14  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/d654/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_36  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/fb46/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_mem_intercon_imp_s00_data_fifo_0/sim/arm_design_axi_mem_intercon_imp_s00_data_fifo_0.v" \

vlog -work axi_protocol_converter_v2_1_37  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/d98a/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/ec67/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/9a25/hdl" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/f0b6/hdl/verilog" "+incdir+../../../../ZC702_EVK_Test.gen/sources_1/bd/arm_design/ipshared/00fe/hdl/verilog" "+incdir+../../../../../../../../../../Xilinx/2025.2/Vivado/data/rsb/busdef" "+incdir+C:/Xilinx/2025.2/Vivado/data/xilinx_vip/include" \
"../../../bd/arm_design/ip/arm_design_axi_mem_intercon_imp_auto_pc_0/sim/arm_design_axi_mem_intercon_imp_auto_pc_0.v" \

vcom -work xil_defaultlib  -93  \
"../../../bd/arm_design/sim/arm_design.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

