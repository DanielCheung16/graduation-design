onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_top/clk_p
add wave -noupdate /test_top/clk_n
add wave -noupdate /test_top/rst_n
add wave -noupdate /test_top/ps2_clk
add wave -noupdate /test_top/ps2_data
add wave -noupdate /test_top/tmds_clk_p
add wave -noupdate /test_top/tmds_clk_n
add wave -noupdate /test_top/tmds_data_p
add wave -noupdate /test_top/tmds_data_n
add wave -noupdate -expand -label sim:/test_top/u_top/u_HDMI_top/Group1 -group {Region: sim:/test_top/u_top/u_HDMI_top} /test_top/u_top/u_HDMI_top/display_vs
add wave -noupdate -expand -label sim:/test_top/u_top/u_HDMI_top/Group1 -group {Region: sim:/test_top/u_top/u_HDMI_top} /test_top/u_top/u_HDMI_top/display_hs
add wave -noupdate -expand -label sim:/test_top/u_top/u_HDMI_top/Group1 -group {Region: sim:/test_top/u_top/u_HDMI_top} -radix unsigned /test_top/u_top/u_HDMI_top/display_xpos
add wave -noupdate -expand -label sim:/test_top/u_top/u_HDMI_top/Group1 -group {Region: sim:/test_top/u_top/u_HDMI_top} -radix unsigned /test_top/u_top/u_HDMI_top/display_ypos
add wave -noupdate -expand -label sim:/test_top/u_top/u_HDMI_top/Group1 -group {Region: sim:/test_top/u_top/u_HDMI_top} /test_top/u_top/u_HDMI_top/data_req
add wave -noupdate -expand -label sim:/test_top/u_top/u_HDMI_top/Group1 -group {Region: sim:/test_top/u_top/u_HDMI_top} /test_top/u_top/u_HDMI_top/display_de
add wave -noupdate -expand -label sim:/test_top/u_top/u_HDMI_top/Group1 -group {Region: sim:/test_top/u_top/u_HDMI_top} /test_top/u_top/u_HDMI_top/pixel_data
add wave -noupdate -expand -label sim:/test_top/u_top/u_HDMI_top/Group1 -group {Region: sim:/test_top/u_top/u_HDMI_top} /test_top/u_top/u_HDMI_top/display_rgb
add wave -noupdate -expand -label sim:/test_top/u_top/Group1 -group {Region: sim:/test_top/u_top} /test_top/u_top/fb_data
add wave -noupdate -expand -label sim:/test_top/u_top/Group1 -group {Region: sim:/test_top/u_top} /test_top/u_top/ctrl_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4148234000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {28992125400 ps}
