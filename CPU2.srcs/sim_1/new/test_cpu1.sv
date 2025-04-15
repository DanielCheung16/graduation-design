`timescale 1ns / 1ps

module test_cpu1(

    );
    parameter CLK_PERIOD_100 = 100; // 周期为 100ns

    // Inputs
    reg clk_100m;
    reg reset;

    //-----------------------------------------------------------------------
    initial begin
        // 初始化时钟信号
        clk_100m = 0;
    end

    always #(CLK_PERIOD_100 / 2) clk_100m = ~clk_100m; // 半周期翻转
    //-----------------------------------------------------------------------
    //-----------------------------------------------------------------------
    initial begin
        // 初始化时钟信号
        reset = 1;
        #((CLK_PERIOD_100 / 2)*3);
        // #(CLK_PERIOD_100);
        // #(CLK_PERIOD_100);
        reset = 0;
    end
    //-----------------------------------------------------------------------
    // output declaration of module top
    wire [31:0] io_debugPort_aluOutput;
    wire io_debugPort_memOutput;
    wire io_debugPort_instOutput;
    wire io_debugPort_pcOutput;
    wire io_debugPort_a0reg;
    wire [5:0] io_debugPort_pcControl;
    wire [1:0] io_debugPort_mem_code;
    wire io_debugPort_mem_size;
    wire io_debugPort_rg_wen;
    wire io_debugPort_control_is_csr_inst;
    wire io_debugPort_control_is_load_inst;
    wire io_debugPort_control_rg_we;
    wire [2:0] io_debugPort_control_reg_w_data;
    wire [3:0] io_debugPort_control_alu_code;
    wire io_debugPort_control_jmp_code;
    wire [1:0] io_debugPort_control_mem_code;
    wire io_debugPort_control_mem_size;
    wire [2:0] io_debugPort_control_sys_code;
    wire [1:0] io_debugPort_control_sys_src1;
    wire io_debugPort_control_rs1_src;
    wire io_debugPort_control_rs2_src;
    wire io_debugPort_control_mem_en;
    wire [2:0] io_debugPort_control_imm_type;
    wire [4:0] io_debugPort_control_rs1;
    wire io_debugPort_control_rs2;
    wire io_debugPort_control_rd;
    wire [11:0] io_debugPort_control_csr_wad;
    wire io_debugPort_jmp_valid;
    wire io_debugPort_is_hazard;
    
    top u_top(
        .clock                             	(clk_100m                           ),
        .reset                             	(reset                              ),
        .io_debugPort_aluOutput            	(io_debugPort_aluOutput             ),
        .io_debugPort_memOutput            	(io_debugPort_memOutput             ),
        .io_debugPort_instOutput           	(io_debugPort_instOutput            ),
        .io_debugPort_pcOutput             	(io_debugPort_pcOutput              ),
        .io_debugPort_a0reg                	(io_debugPort_a0reg                 ),
        .io_debugPort_pcControl            	(io_debugPort_pcControl             ),
        .io_debugPort_mem_code             	(io_debugPort_mem_code              ),
        .io_debugPort_mem_size             	(io_debugPort_mem_size              ),
        .io_debugPort_rg_wen               	(io_debugPort_rg_wen                ),
        .io_debugPort_control_is_csr_inst  	(io_debugPort_control_is_csr_inst   ),
        .io_debugPort_control_is_load_inst 	(io_debugPort_control_is_load_inst  ),
        .io_debugPort_control_rg_we        	(io_debugPort_control_rg_we         ),
        .io_debugPort_control_reg_w_data   	(io_debugPort_control_reg_w_data    ),
        .io_debugPort_control_alu_code     	(io_debugPort_control_alu_code      ),
        .io_debugPort_control_jmp_code     	(io_debugPort_control_jmp_code      ),
        .io_debugPort_control_mem_code     	(io_debugPort_control_mem_code      ),
        .io_debugPort_control_mem_size     	(io_debugPort_control_mem_size      ),
        .io_debugPort_control_sys_code     	(io_debugPort_control_sys_code      ),
        .io_debugPort_control_sys_src1     	(io_debugPort_control_sys_src1      ),
        .io_debugPort_control_rs1_src      	(io_debugPort_control_rs1_src       ),
        .io_debugPort_control_rs2_src      	(io_debugPort_control_rs2_src       ),
        .io_debugPort_control_mem_en       	(io_debugPort_control_mem_en        ),
        .io_debugPort_control_imm_type     	(io_debugPort_control_imm_type      ),
        .io_debugPort_control_rs1          	(io_debugPort_control_rs1           ),
        .io_debugPort_control_rs2          	(io_debugPort_control_rs2           ),
        .io_debugPort_control_rd           	(io_debugPort_control_rd            ),
        .io_debugPort_control_csr_wad      	(io_debugPort_control_csr_wad       ),
        .io_debugPort_jmp_valid            	(io_debugPort_jmp_valid             ),
        .io_debugPort_is_hazard            	(io_debugPort_is_hazard             )
    );
    
endmodule
