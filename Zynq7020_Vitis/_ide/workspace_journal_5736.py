# 2025-12-08T08:27:07.590916700
import vitis

client = vitis.create_client()
client.set_workspace(path="Zynq7020_Vitis")

platform = client.create_platform_component(name = "zynq_125mhz",hw_design = "$COMPONENT_LOCATION/../../top_module_125mhz.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

platform = client.create_platform_component(name = "zynq_142mhz",hw_design = "$COMPONENT_LOCATION/../../top_module_142mhz.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

platform = client.get_component(name="zynq_perf")
status = platform.build()

comp = client.get_component(name="dma_ddr_interrupt_multi")
comp.build()

platform = client.get_component(name="zynq_125mhz")
status = platform.build()

platform = client.get_component(name="zynq_perf")
status = platform.build()

comp.build()

status = platform.build()

comp.build()

client.delete_component(name="zynq_125mhz")

platform = client.create_platform_component(name = "zynq125mhz",hw_design = "$COMPONENT_LOCATION/../../top_module_125mhz.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

platform = client.get_component(name="zynq125mhz")
status = platform.build()

client.delete_component(name="zynq125mhz")

client.delete_component(name="zynq_142mhz")

platform = client.create_platform_component(name = "zynq125mhz",hw_design = "$COMPONENT_LOCATION/../../top_module.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

status = platform.build()

comp.build()

comp.build()

comp = client.create_app_component(name="multi_test125",platform = "$COMPONENT_LOCATION/../zynq125mhz/export/zynq125mhz/zynq125mhz.xpfm",domain = "standalone_ps7_cortexa9_0",template = "hello_world")

status = platform.build()

comp = client.get_component(name="multi_test125")
comp.build()

platform = client.create_platform_component(name = "zynq142mhz",hw_design = "$COMPONENT_LOCATION/../../top_module.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

comp = client.create_app_component(name="multi_test142",platform = "$COMPONENT_LOCATION/../zynq142mhz/export/zynq142mhz/zynq142mhz.xpfm",domain = "standalone_ps7_cortexa9_0",template = "hello_world")

platform = client.get_component(name="zynq142mhz")
status = platform.build()

comp = client.get_component(name="multi_test142")
comp.build()

client.delete_component(name="dma_ddr_interrupt_multi")

client.delete_component(name="componentName")

client.delete_component(name="zynq_perf")

platform = client.create_platform_component(name = "zynq_perf",hw_design = "$COMPONENT_LOCATION/../../top_module.xsa",os = "standalone",cpu = "ps7_cortexa9_0",domain_name = "standalone_ps7_cortexa9_0",compiler = "gcc")

client.delete_component(name="lwip_tcp_perf_server")

vitis.dispose()

