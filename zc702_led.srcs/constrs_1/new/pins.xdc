
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVDS_25 DIFF_TERM 1} [get_ports sys_clk_p]
set_property -dict {PACKAGE_PIN C19 IOSTANDARD LVDS_25 DIFF_TERM 1} [get_ports sys_clk_n]

set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS25} [get_ports o_led_n]

create_clock -period 5.000 -name clk [get_ports sys_clk_p]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 6 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list u_clk/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {q_cnt[0]} {q_cnt[1]} {q_cnt[2]} {q_cnt[3]} {q_cnt[4]} {q_cnt[5]} {q_cnt[6]} {q_cnt[7]} {q_cnt[8]} {q_cnt[9]} {q_cnt[10]} {q_cnt[11]} {q_cnt[12]} {q_cnt[13]} {q_cnt[14]} {q_cnt[15]} {q_cnt[16]} {q_cnt[17]} {q_cnt[18]} {q_cnt[19]} {q_cnt[20]} {q_cnt[21]} {q_cnt[22]} {q_cnt[23]} {q_cnt[24]} {q_cnt[25]} {q_cnt[26]} {q_cnt[27]} {q_cnt[28]} {q_cnt[29]} {q_cnt[30]} {q_cnt[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list o_led_n_OBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_out1]
