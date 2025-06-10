onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_test2/clk_100m
add wave -noupdate /cpu_test2/reset
add wave -noupdate -expand -group 流水线指令 /cpu_test2/u_top/u_cpu/if_id/io_in_cur_pc
add wave -noupdate -expand -group 流水线指令 /cpu_test2/u_top/u_cpu/if_id/io_in_inst
add wave -noupdate -expand -group 流水线指令 /cpu_test2/u_top/u_cpu/if_id/io_out_inst
add wave -noupdate -expand -group 流水线指令 /cpu_test2/u_top/u_cpu/id_ex/io_out_if_data_inst
add wave -noupdate -expand -group 流水线指令 /cpu_test2/u_top/u_cpu/ex_mem/io_out_if_data_inst
add wave -noupdate -expand -group 流水线指令 /cpu_test2/u_top/u_cpu/mem_wb/io_out_if_data_inst
add wave -noupdate -expand -group dmem -color Goldenrod -label exe_inst /cpu_test2/u_top/u_cpu/id_ex/io_out_if_data_inst
add wave -noupdate -expand -group dmem -label Addr_cpu /cpu_test2/u_top/u_mmio_bus/Addr_cpu
add wave -noupdate -expand -group dmem /cpu_test2/u_top/u_mmio_bus/wea_dmem
add wave -noupdate -expand -group dmem /cpu_test2/u_top/u_mmio_bus/douta_dmem
add wave -noupdate -expand -group dmem /cpu_test2/u_top/u_mmio_bus/dout_cpu
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {822105 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 262
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
WaveRestoreZoom {0 ps} {1090598 ps}
