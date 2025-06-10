onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_cpu1/clk_100m
add wave -noupdate /test_cpu1/reset
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_aluOutput
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_memOutput
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_instOutput
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_pcOutput
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_a0reg
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_pcControl
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_mem_code
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_mem_size
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_rg_wen
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_is_csr_inst
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_is_load_inst
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_rg_we
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_reg_w_data
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_alu_code
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_jmp_code
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_mem_code
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_mem_size
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_sys_code
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_sys_src1
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_rs1_src
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_rs2_src
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_mem_en
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_imm_type
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_rs1
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_rs2
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_rd
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_control_csr_wad
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_jmp_valid
add wave -noupdate -label sim:/test_cpu1/Group1 -group {Region: sim:/test_cpu1} /test_cpu1/io_debugPort_is_hazard
add wave -noupdate -expand -label sim:/test_cpu1/u_top/if_id/Group1 -group {Region: sim:/test_cpu1/u_top/if_id} /test_cpu1/u_top/if_id/io_in_cur_pc
add wave -noupdate -expand -label sim:/test_cpu1/u_top/if_id/Group1 -group {Region: sim:/test_cpu1/u_top/if_id} /test_cpu1/u_top/if_id/io_in_inst
add wave -noupdate -expand -label sim:/test_cpu1/u_top/if_id/Group1 -group {Region: sim:/test_cpu1/u_top/if_id} /test_cpu1/u_top/if_id/io_out_cur_pc
add wave -noupdate -expand -label sim:/test_cpu1/u_top/if_id/Group1 -group {Region: sim:/test_cpu1/u_top/if_id} /test_cpu1/u_top/if_id/io_out_inst
add wave -noupdate -expand -label sim:/test_cpu1/u_top/lsu/Group1 -group {Region: sim:/test_cpu1/u_top/lsu} /test_cpu1/u_top/lsu/io_in1_out_alu_out
add wave -noupdate -expand -label sim:/test_cpu1/u_top/lsu/Group1 -group {Region: sim:/test_cpu1/u_top/lsu} /test_cpu1/u_top/lsu/io_ctrl_out_out_mem_out
add wave -noupdate /test_cpu1/u_top/ex/io_ctrl_out_out_alu_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1050 ns}
