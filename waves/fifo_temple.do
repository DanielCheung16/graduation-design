onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_ky/clk_cpu
add wave -noupdate /test_ky/reset
add wave -noupdate /test_ky/ps2_clk
add wave -noupdate /test_ky/ps2_data
add wave -noupdate /test_ky/mmio_en
add wave -noupdate /test_ky/data_out
add wave -noupdate -expand -group fifo /test_ky/u_ky/u_ps2_fifo_0/din
add wave -noupdate -expand -group fifo /test_ky/u_ky/u_ps2_fifo_0/wr_en
add wave -noupdate -expand -group fifo /test_ky/u_ky/u_ps2_fifo_0/rd_en
add wave -noupdate -expand -group fifo /test_ky/u_ky/u_ps2_fifo_0/dout
add wave -noupdate -expand -group fifo /test_ky/u_ky/u_ps2_fifo_0/full
add wave -noupdate -expand -group fifo /test_ky/u_ky/u_ps2_fifo_0/empty
add wave -noupdate -expand -group fifo /test_ky/u_ky/u_ps2_rx/valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2200256185 ps} 0}
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
WaveRestoreZoom {0 ps} {24150 us}
