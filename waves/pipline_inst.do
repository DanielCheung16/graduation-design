onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_bolloon/u_top/clk_50m
add wave -noupdate /test_bolloon/u_top/u_core/u_cpu/reset
add wave -noupdate -color Gold /test_bolloon/u_top/u_core/u_cpu/ifu/io_out_cur_pc
add wave -noupdate -expand -group {pipe inst} -label IF_inst /test_bolloon/u_top/u_core/u_cpu/if_id/io_in_inst
add wave -noupdate -expand -group {pipe inst} -label ID_inst /test_bolloon/u_top/u_core/u_cpu/if_id/io_out_inst
add wave -noupdate -expand -group {pipe inst} -label EX_inst /test_bolloon/u_top/u_core/u_cpu/id_ex/io_out_if_data_inst
add wave -noupdate -expand -group {pipe inst} -label MEM_inst /test_bolloon/u_top/u_core/u_cpu/ex_mem/io_out_if_data_inst
add wave -noupdate -expand -group {pipe inst} -label WB_inst /test_bolloon/u_top/u_core/u_cpu/mem_wb/io_out_if_data_inst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100493769 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 155
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
configure wave -timelineunits ps
update
WaveRestoreZoom {100368570 ps} {100533860 ps}
