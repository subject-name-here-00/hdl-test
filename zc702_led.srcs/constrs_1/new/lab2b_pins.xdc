set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVDS_25 DIFF_TERM 1} [get_ports i_clk_p]
set_property -dict {PACKAGE_PIN C19 IOSTANDARD LVDS_25 DIFF_TERM 1} [get_ports i_clk_n]

set_property -dict {PACKAGE_PIN F19 IOSTANDARD LVCMOS25} [get_ports i_sel[1]]
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS25} [get_ports i_sel[0]]

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25} [get_ports {o_led[7]}]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports {o_led[6]}]
set_property -dict {PACKAGE_PIN W10 IOSTANDARD LVCMOS25} [get_ports {o_led[5]}]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS25} [get_ports {o_led[4]}]
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS25} [get_ports {o_led[3]}]
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS25} [get_ports {o_led[2]}]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS25} [get_ports {o_led[1]}]
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS25} [get_ports {o_led[0]}]
