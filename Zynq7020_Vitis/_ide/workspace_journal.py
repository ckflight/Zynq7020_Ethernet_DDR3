# 2025-12-01T15:38:26.127316400
import vitis

client = vitis.create_client()
client.set_workspace(path="Zynq7020_Vitis")

platform = client.get_component(name="zynq_perf")
status = platform.build()

comp = client.get_component(name="lwip_tcp_perf_server")
comp.build()

client.delete_component(name="lwip_tcp_perf_server")

domain = platform.get_domain(name="standalone_ps7_cortexa9_0")

status = domain.set_config(option = "lib", param = "lwip220_dhcp", value = "true", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_lwip_dhcp_does_acd_check", value = "true", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_mem_size", value = "524288", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_memp_n_pbuf", value = "1024", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_memp_n_tcp_seg", value = "1024", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_pbuf_pool_size", value = "16384", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_tcp_snd_buf", value = "65535", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_tcp_wnd", value = "65535", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_n_rx_descriptors", value = "512", lib_name="lwip220")

status = domain.set_config(option = "lib", param = "lwip220_n_tx_descriptors", value = "512", lib_name="lwip220")

status = platform.build()

status = platform.build()

comp = client.get_component(name="dma_ddr_interrupt_benchmark")
comp.build()

comp = client.create_app_component(name="lwip_tcp_perf_server",platform = "$COMPONENT_LOCATION/../zynq_perf/export/zynq_perf/zynq_perf.xpfm",domain = "standalone_ps7_cortexa9_0",template = "lwip_tcp_perf_server")

status = platform.build()

comp = client.get_component(name="lwip_tcp_perf_server")
comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp = client.get_component(name="dma_ddr_interrupt_benchmark")
comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../top_module.xsa")

status = platform.build()

comp.build()

