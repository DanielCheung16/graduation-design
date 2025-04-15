module imem(
    input clock,
    input [31:0] Addr,
    output [31:0] Inst
    );
//----------------------------参数定义------------------------------------------
    localparam IMEM_BASE = 32'h80000000;
    localparam IMEM_SIZE = 32'h0800 * 4; // 2048*4 = 8KB
    localparam IMEM_END  = IMEM_BASE + IMEM_SIZE - 1;

    wire    [10:0] addra_word = (Addr - IMEM_BASE)>>2;
//-----------------------------------------------------------------------------
    wire [31:0] douta;
    assign Inst = douta;
    
    imem_ip u_imem_ip(
        .clka  	(clock   ),
        .ena   	(1    ),
        .addra 	(addra_word  ),
        .douta 	(douta  )
    );
    
endmodule

// module imem(
//     input clock,
//     input [31:0] Addr,
//     output [31:0] Inst
//     );
//     localparam IMEM_SIZE = 32'h0800;
//     // 声明一个 8KB 的 data_memory，按字节寻址
//     reg [31:0] imem [0:IMEM_SIZE-1];   // 8KB = 8192 Bytes

//     wire [10:0] word_addr = Addr[12:2]; // 屏蔽高位,取 word 地址（字对齐）
//     //读取：
//     reg [31:0] data_reg;      // 数据寄存器
//     assign Inst = data_reg;

//     //读写：
//     always @(posedge clock) begin
//         data_reg <= imem[word_addr];
//     end

//     // ======================
//     // 初始化内存（仿真时可加载指令）
//     // ======================
//     initial begin
//         $readmemh("E:/FPGA/Senior1/CPU2/CPU2.sim/init.txt", imem);  // 可将ROM数据写入此文件，仿真时加载
//     end

// endmodule