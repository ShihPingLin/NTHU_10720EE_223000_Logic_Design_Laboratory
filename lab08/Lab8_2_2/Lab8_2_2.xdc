#input
set_property IOSTANDARD LVCMOS33 [get_ports in_up]
set_property PACKAGE_PIN T18 [get_ports in_up]

set_property IOSTANDARD LVCMOS33 [get_ports in_down]
set_property PACKAGE_PIN U17 [get_ports in_down]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN W5 [get_ports clk]

set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN V17 [get_ports rst_n]

# Pmod I2S
set_property IOSTANDARD LVCMOS33 [get_ports audio_mclk]
set_property PACKAGE_PIN A14 [get_ports audio_mclk]
set_property IOSTANDARD LVCMOS33 [get_ports audio_lrck]
set_property PACKAGE_PIN A16 [get_ports audio_lrck]
set_property IOSTANDARD LVCMOS33 [get_ports audio_sck]
set_property PACKAGE_PIN B15 [get_ports audio_sck]
set_property IOSTANDARD LVCMOS33 [get_ports audio_sdin]
set_property PACKAGE_PIN B16 [get_ports audio_sdin]

#output port
set_property IOSTANDARD LVCMOS33 [get_ports {segs[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segs[0]}]
set_property PACKAGE_PIN W7 [get_ports {segs[6]}]
set_property PACKAGE_PIN W6 [get_ports {segs[5]}]
set_property PACKAGE_PIN U8 [get_ports {segs[4]}]
set_property PACKAGE_PIN V8 [get_ports {segs[3]}]
set_property PACKAGE_PIN U5 [get_ports {segs[2]}]
set_property PACKAGE_PIN V5 [get_ports {segs[1]}]
set_property PACKAGE_PIN U7 [get_ports {segs[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ssd_ctl[0]}]
set_property PACKAGE_PIN W4 [get_ports {ssd_ctl[3]}]
set_property PACKAGE_PIN V4 [get_ports {ssd_ctl[2]}]
set_property PACKAGE_PIN U4 [get_ports {ssd_ctl[1]}]
set_property PACKAGE_PIN U2 [get_ports {ssd_ctl[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports point]
set_property PACKAGE_PIN V7 [get_ports point]

