


create_waiver -internal -scope -type METHODOLOGY -id {LUTAR-1} -user "axi_data_fifo" -desc {the pathway is completely within fifo-gen, and that path is present single-clock usage} -tags "1024446"\
 -objects [get_pins -hierarchical * -filter "(NAME=~*gen_fifo.fifo_gen_inst/inst_fifo_gen/gaxi_full_lite.gwrite_ch.gwach*.axi_wach/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/gpregsm1.curr_fwft_state_reg*/CLR)"] 

create_waiver -internal -scope -type METHODOLOGY -id {LUTAR-1} -user "axi_data_fifo" -desc {the pathway is completely within fifo-gen, and that path is present single-clock usage} -tags "1024446"\
 -objects [get_pins -hierarchical * -filter "(NAME=~*gen_fifo.fifo_gen_inst/inst_fifo_gen/gaxi_full_lite.gwrite_ch.gwach*.axi_wach/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/gpregsm1.user_valid_reg*/CLR)"] 

create_waiver -internal -scope -type METHODOLOGY -id {LUTAR-1} -user "axi_data_fifo" -desc {the pathway is completely within fifo-gen, and that path is present single-clock usage} -tags "1024446"\
 -objects [get_pins -hierarchical * -filter "(NAME=~*gen_fifo.fifo_gen_inst/inst_fifo_gen/gaxi_full_lite.gwrite_ch.gwach*.axi_wach/grf.rf/gntv_or_sync_fifo.gl0.rd/grss.rsts/ram_empty_*_reg*/PRE)"] 

create_waiver -internal -scope -type METHODOLOGY -id {LUTAR-1} -user "axi_data_fifo" -desc {the pathway is completely within fifo-gen, and that path is present single-clock usage} -tags "1024446"\
 -objects [get_pins -hierarchical * -filter "(NAME=~*gen_fifo.fifo_gen_inst/inst_fifo_gen/gaxi_full_lite.gwrite_ch.gwach*.axi_wach/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gcc0.gc0.count_d1_reg*/CLR)"] 

create_waiver -internal -scope -type METHODOLOGY -id {LUTAR-1} -user "axi_data_fifo" -desc {the pathway is completely within fifo-gen, and that path is present single-clock usage} -tags "1024446"\
 -objects [get_pins -hierarchical * -filter "(NAME=~*gen_fifo.fifo_gen_inst/inst_fifo_gen/gaxi_full_lite.gwrite_ch.gwach*.axi_wach/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gcc0.gc0.count_reg*/PRE)"] 

create_waiver -internal -scope -type METHODOLOGY -id {LUTAR-1} -user "axi_data_fifo" -desc {the pathway is completely within fifo-gen, and that path is present single-clock usage} -tags "1024446"\
 -objects [get_pins -hierarchical * -filter "(NAME=~*gen_fifo.fifo_gen_inst/inst_fifo_gen/gaxi_full_lite.gwrite_ch.gwach*.axi_wach/grf.rf/gntv_or_sync_fifo.gl0.wr/wpntr/gcc0.gc0.count_reg*/CLR)"] 



