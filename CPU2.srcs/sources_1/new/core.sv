module core(
    input       clock_cpu,
    input       rst_cpu,
    //mmio_devices
    input  wire         clock_vga,
    input  wire  [16:0] addrb_vga,
    output wire  [31:0] doutb_vga,
    
    input  wire  [3:0]  web_vga_ctrl,
    input  wire  [0:0]  addrb_vga_ctrl,
    input  wire  [31:0] dinb_vga_ctrl,
    output wire  [31:0] doutb_vga_ctrl,
    
    input  wire         ps2_clk,
    input  wire         ps2_data
    );

    // output declaration of module cpu
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
    wire [31:0] Addr_cpu;
    wire [31:0] WD_cpu;
    wire WE_cpu;
    wire [1:0] LEN_cpu;
    
    // output declaration of module mmio_bus
    wire    [31:0]  dout_cpu;
    
    cpu u_cpu(
        .clock                             	(clock_cpu                          ),
        .reset                             	(rst_cpu                            ),
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
        .io_debugPort_is_hazard            	(io_debugPort_is_hazard             ),
        .Addr_cpu                          	(Addr_cpu                           ),
        .WD_cpu                            	(WD_cpu                             ),
        .WE_cpu                            	(WE_cpu                             ),
        .LEN_cpu                           	(LEN_cpu                            ),
        .dout_cpu                          	(dout_cpu                           )
    );
    
    mmio_bus u_mmio_bus(
        //to cpu
        .clock_cpu      	(clock_cpu       ),
        .rst_cpu        	(rst_cpu         ),
        .Addr_cpu       	(Addr_cpu        ),
        .WD_cpu         	(WD_cpu          ),
        .WE_cpu         	(WE_cpu          ),
        .LEN_cpu        	(LEN_cpu         ),
        .dout_cpu       	(dout_cpu        ),
        //to vga
        .clock_vga      	(clock_vga       ),
        .addrb_vga      	(addrb_vga       ),
        .doutb_vga      	(doutb_vga       ),
        .web_vga_ctrl   	(web_vga_ctrl    ),
        .addrb_vga_ctrl 	(addrb_vga_ctrl  ),
        .dinb_vga_ctrl  	(dinb_vga_ctrl   ),
        .doutb_vga_ctrl 	(doutb_vga_ctrl  ),
        //to keyboard
        .ps2_clk        	(ps2_clk         ),
        .ps2_data       	(ps2_data        )
    );
    
endmodule
