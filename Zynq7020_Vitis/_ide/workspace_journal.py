# 2025-12-08T14:35:45.330074700
import vitis

client = vitis.create_client()
client.set_workspace(path="Zynq7020_Vitis")

platform = client.get_component(name="zynq_perf")
status = platform.build()

domain = platform.get_domain(name="standalone_ps7_cortexa9_0")

status = domain.set_lib(lib_name="lwip220", path="C:\Xilinx\2025.2\Vitis\data\embeddedsw\ThirdParty\sw_services\lwip220_v1_3")

status = domain.set_config(option = "lib", param = "XILTIMER_en_interval_timer", value = "true", lib_name="xiltimer")

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

comp = client.get_component(name="tcp_perf_echo_server")
comp.build()

comp.build()

comp.build()

comp.build()

comp = client.create_app_component(name="dma_ddr_interrupt_multi",platform = "$COMPONENT_LOCATION/../zynq_perf/export/zynq_perf/zynq_perf.xpfm",domain = "standalone_ps7_cortexa9_0",template = "hello_world")

status = platform.build()

comp = client.get_component(name="dma_ddr_interrupt_multi")
comp.build()

platform = client.get_component(name="zynq142mhz")
status = platform.build()

comp = client.get_component(name="multi_test142")
comp.build()

