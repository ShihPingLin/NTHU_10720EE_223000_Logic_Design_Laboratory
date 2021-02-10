#input
set_property IOSTANDARD LVCMOS33 [get_ports in_do]
set_property PACKAGE_PIN W19 [get_ports in_do]

set_property IOSTANDARD LVCMOS33 [get_ports in_re]
set_property PACKAGE_PIN U18 [get_ports in_re]

set_property IOSTANDARD LVCMOS33 [get_ports in_mi]
set_property PACKAGE_PIN T17 [get_ports in_mi]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN W5 [get_ports clk]

set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN V17 [get_ports rst_n]

#ourput
set_property IOSTANDARD LVCMOS33 [get_ports {state[0]}]
set_property PACKAGE_PIN U16 [get_ports {state[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {state[1]}]
set_property PACKAGE_PIN E19 [get_ports {state[1]}]

# Pmod I2S
set_property IOSTANDARD LVCMOS33 [get_ports audio_mclk]
set_property PACKAGE_PIN A14 [get_ports audio_mclk]
set_property IOSTANDARD LVCMOS33 [get_ports audio_lrck]
set_property PACKAGE_PIN A16 [get_ports audio_lrck]
set_property IOSTANDARD LVCMOS33 [get_ports audio_sck]
set_property PACKAGE_PIN B15 [get_ports audio_sck]
set_property IOSTANDARD LVCMOS33 [get_ports audio_sdin]
set_property PACKAGE_PIN B16 [get_ports audio_sdin]

