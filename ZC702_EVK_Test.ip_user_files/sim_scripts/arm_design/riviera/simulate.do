transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+arm_design  -L xil_defaultlib -L xilinx_vip -L xpm -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_22 -L processing_system7_vip_v1_0_24 -L axi_datamover_v5_1_37 -L axi_sg_v4_1_21 -L axi_dma_v7_1_37 -L proc_sys_reset_v5_0_17 -L smartconnect_v1_0 -L axi_register_slice_v2_1_36 -L axi_lite_ipif_v3_0_4 -L interrupt_control_v3_1_5 -L axi_gpio_v2_0_37 -L generic_baseblocks_v2_1_2 -L fifo_generator_v13_2_14 -L axi_data_fifo_v2_1_36 -L axi_protocol_converter_v2_1_37 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.arm_design xil_defaultlib.glbl

do {arm_design.udo}

run 1000ns

endsim

quit -force
