onerror {resume}
quietly virtual signal -install /test_ky { /test_ky/data_out[7:0]} hh
quietly virtual signal -install /test_ky { /test_ky/data_out[15:0]} data_out_low16
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_ky/clk_cpu
add wave -noupdate /test_ky/reset
add wave -noupdate -expand -group signal /test_ky/u_ky/scan_code
add wave -noupdate -expand -group signal /test_ky/u_ky/scan_valid
add wave -noupdate -expand -group signal /test_ky/u_ky/key_up
add wave -noupdate -expand -group signal -divider -height 40 non
add wave -noupdate -expand -group signal /test_ky/u_ky/wr_en
add wave -noupdate -expand -group signal /test_ky/u_ky/fifo_din
add wave -noupdate -expand -group read /test_ky/mmio_en
add wave -noupdate -expand -group read /test_ky/data_out_low16
add wave -noupdate -expand -group read /test_ky/u_ky/empty
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2777666 ps} 0}
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
WaveRestoreZoom {0 ps} {5250 ns}
