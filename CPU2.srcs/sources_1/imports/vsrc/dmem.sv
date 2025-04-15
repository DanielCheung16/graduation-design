module dmem(
        input  wire         clock_cpu,
        input  wire         rst_cpu,
        input  wire  [3:0]  wea,
        input  wire  [31:0] addra,
        input  wire  [31:0] dina,
        output wire  [31:0] douta
    );
//----------------------------参数定义------------------------------------------
    localparam DMEM_BASE = 32'h80000000;
    localparam DMEM_SIZE = 16'h4000 * 4; // 16384*4 = 64KB
    localparam DMEM_END  = DMEM_BASE + DMEM_SIZE - 1;
    
    wire    [13:0] addra_word = (addra - DMEM_BASE)>>2;    
    reg     [1:0]  addra_offset;
    wire    [31:0] douta_t;
//------------------------------------------------------------------------------
    always @(posedge clock_cpu) begin                   //addra_offset会决定输出的调整
        if(rst_cpu)begin
            addra_offset <= 2'b0;
        end else begin
            addra_offset    <=  addra[1:0];
        end
    end

    assign douta = douta_t >> (8*addra_offset);
    
    bmem_ip u_bmem_mmio(
        .clka  	(clock_cpu   ),
        .ena   	(1    ),
        .wea   	(wea    ),
        .addra 	(addra_word  ),
        .dina  	(dina   ),
        .douta 	(douta_t  )
    );
    
endmodule

// module dmem (
//     input clock,
//     input [31:0] Addr,
//     input [31:0] WD,
//     input WE,
//     input [1:0] LEN,
//     output [31:0] Inst
// );
//     localparam DMEM_SIZE = 16'h4000; // 16384
//     // 声明一个 8KB 的 data_memory，按字节寻址
//     (*ram_style = "block"*) reg [31:0] dmem [0:DMEM_SIZE-1];   // 64KB = 16384*4 Bytes

//     wire [13:0] word_addr = Addr[15:2]; // 屏蔽高位,取 word 地址（字对齐）
//     //读取：
//     reg [31:0] data_reg;      // 数据寄存器
//     assign Inst = data_reg;

//     //读写：
//     always @(posedge clock) begin
//         if (WE) begin
//             case (LEN)
//                 2'b00: begin  // SB
//                     case (Addr[1:0])
//                         2'b00: dmem[word_addr] <= {dmem[word_addr][31:8], WD[7:0]};
//                         2'b01: dmem[word_addr] <= {dmem[word_addr][31:16], WD[7:0], dmem[word_addr][7:0]};
//                         2'b10: dmem[word_addr] <= {dmem[word_addr][31:24], WD[7:0], dmem[word_addr][15:0]};
//                         2'b11: dmem[word_addr] <= {WD[7:0], dmem[word_addr][23:0]};
//                     endcase
//                 end

//                 2'b01: begin  // SH
//                     case (Addr[1:0])
//                         2'b00: dmem[word_addr] <= {dmem[word_addr][31:16], WD[15:0]};
//                         2'b01: dmem[word_addr] <= {dmem[word_addr][31:24], WD[15:0], dmem[word_addr][7:0]};
//                         2'b10: dmem[word_addr] <= {WD[15:0], dmem[word_addr][15:0]};
//                         // Addr[1:0]==2'b11 是未对齐半字写入，非法（跨 word）→ 视实现选择处理：丢弃或报错
//                         default: ; // 忽略写入
//                     endcase
//                 end

//                 2'b10: begin  // SW
//                     dmem[word_addr] <= WD;
//                 end
//                 default: dmem[word_addr] <= WD;
//             endcase
//         end else begin
//             data_reg <= dmem[word_addr];  // 简化起见这里按字读取，lb/lh在decode/ex阶段处理
//         end
//     end

//     // ======================
//     // 初始化内存（仿真时可加载指令）
//     // ======================
//     initial begin
//         $readmemh("E:/FPGA/Senior1/CPU2/CPU2.sim/init_dmem.txt", dmem);  // 可将ROM数据写入此文件，仿真时加载
//     end

// endmodule
