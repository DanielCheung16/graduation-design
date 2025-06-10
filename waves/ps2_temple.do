onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_ps2/clk_cpu
add wave -noupdate /test_ps2/ps2_clk
add wave -noupdate /test_ps2/reset
add wave -noupdate /test_ps2/ps2_data
add wave -noupdate /test_ps2/scan_code
add wave -noupdate /test_ps2/valid
add wave -noupdate -expand -label sim:/test_ps2/u_ps2_rx/Group1 -group {Region: sim:/test_ps2/u_ps2_rx} /test_ps2/u_ps2_rx/ps2_clk_neg
add wave -noupdate -expand -label sim:/test_ps2/u_ps2_rx/Group1 -group {Region: sim:/test_ps2/u_ps2_rx} /test_ps2/u_ps2_rx/ps2_clk_sync0
add wave -noupdate -expand -label sim:/test_ps2/u_ps2_rx/Group1 -group {Region: sim:/test_ps2/u_ps2_rx} /test_ps2/u_ps2_rx/ps2_clk_sync1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2150010000 ps} 0} {{Cursor 2} {23844282 ps} 0} {{Cursor 3} {2149663639 ps} 0}
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
WaveRestoreZoom {2149651269 ps} {2150416945 ps}
