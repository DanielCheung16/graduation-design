# set_property PACKAGE_PIN B19 [get_ports rst_n]
# set_property IOSTANDARD LVCMOS12 [get_ports rst_n]
set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS12 } [get_ports { rst_n }];

# Clock Signal
set_property -dict { PACKAGE_PIN AD11  IOSTANDARD LVDS     } [get_ports { clk_n }]; 
set_property -dict { PACKAGE_PIN AD12  IOSTANDARD LVDS     } [get_ports { clk_p }]; 

# HDMI out
set_property -dict { PACKAGE_PIN AC20  IOSTANDARD TMDS_33  } [get_ports {tmds_data_p[0]}];
set_property -dict { PACKAGE_PIN AC21  IOSTANDARD TMDS_33  } [get_ports {tmds_data_n[0]}];
set_property -dict { PACKAGE_PIN AA22  IOSTANDARD TMDS_33  } [get_ports {tmds_data_p[1]}];
set_property -dict { PACKAGE_PIN AA23  IOSTANDARD TMDS_33  } [get_ports {tmds_data_n[1]}];
set_property -dict { PACKAGE_PIN AB24  IOSTANDARD TMDS_33  } [get_ports {tmds_data_p[2]}];
set_property -dict { PACKAGE_PIN AC25  IOSTANDARD TMDS_33  } [get_ports {tmds_data_n[2]}];

set_property -dict { PACKAGE_PIN AA20  IOSTANDARD TMDS_33  } [get_ports { tmds_clk_p }];
set_property -dict { PACKAGE_PIN AB20  IOSTANDARD TMDS_33  } [get_ports { tmds_clk_n }];

#PS2
# set_property PULLUP true [get_ports { ps2_clk }]
# set_property PULLUP true [get_ports { ps2_data }]
set_property -dict { PACKAGE_PIN AD23  IOSTANDARD LVCMOS33 } [get_ports { ps2_clk }]; #IO_L12P_T1_MRCC_12 Sch=ps2_clk[0]
set_property -dict { PACKAGE_PIN AE20  IOSTANDARD LVCMOS33 } [get_ports { ps2_data }]; #IO_25_12 Sch=ps2_data[0]

# #LED
set_property -dict { PACKAGE_PIN T28   IOSTANDARD LVCMOS33 } [get_ports { led_rst }];
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { led_ky }];

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets u_PLL/my_clk_pll2_0/inst/clk_in1_clk_pll2] 