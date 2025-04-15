`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/20 16:31:03
// Design Name: 
// Module Name: Serializer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Serializer(
    input sys_rst_n,
    input clk_1x,           //输入的并行时钟
    input clk_5x,           //输入的穿行时钟
    input [9:0] par_data,   //经过编码后的10bit数据

    output ser_data_p,
    output ser_data_n
    );
//*****************************************************************
//      参数定义
//*****************************************************************
    wire cascade1;      //用于两个OSERDESE2级联
    wire cascade2;    
    wire ser_data;
//*****************************************************************
//      Main part
//***************************************************************** 
//例化OSERDESE2原语，Master部分
    OSERDESE2 #(
        .DATA_RATE_OQ("DDR"),   // DDR, SDR
        .DATA_RATE_TQ("SDR"),   // DDR, BUF, SDR
        .DATA_WIDTH(10),         // Parallel data width (2-8,10,14)
        .SERDES_MODE("MASTER"), // MASTER, SLAVE
        .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
        .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
        .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
    )
    OSERDESE2_MASTER (
        .CLK        (clk_5x),            // 1-bit input: High speed clock
        .CLKDIV     (clk_1x),            // 1-bit input: Divided clock
        .RST        (~sys_rst_n),             // 1-bit input: Reset
        .OCE        (1'b1),              // 1-bit input: Output data clock enable

        .OQ         (ser_data),          // 1-bit output: Data path output
        // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
        .D1         (par_data[0]),
        .D2         (par_data[1]),
        .D3         (par_data[2]),
        .D4         (par_data[3]),
        .D5         (par_data[4]),
        .D6         (par_data[5]),
        .D7         (par_data[6]),
        .D8         (par_data[7]),

        // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
        .SHIFTIN1   (cascade1),
        .SHIFTIN2   (cascade2),
        // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
        .SHIFTOUT1  (),
        .SHIFTOUT2  (),

        //以下信号未使用
        .OFB        (),             // 1-bit output: Feedback path for data 
        // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
        .T1         (1'b0),
        .T2         (1'b0),
        .T3         (1'b0),
        .T4         (1'b0),
        .TBYTEIN    (1'b0),         // 1-bit input: Byte group tristate
        .TCE        (1'b0),         // 1-bit input: 3-state clock enable
        .TBYTEOUT   (),             // 1-bit output: Byte group tristate
        .TFB        (),             // 1-bit output: 3-state control
        .TQ         ()              // 1-bit output: 3-state control        
    );

//例化OSERDESE2原语，Slave部分
    OSERDESE2 #(
        .DATA_RATE_OQ("DDR"),   // DDR, SDR
        .DATA_RATE_TQ("SDR"),   // DDR, BUF, SDR
        .DATA_WIDTH(10),         // Parallel data width (2-8,10,14)
        .SERDES_MODE("SLAVE"), // MASTER, SLAVE
        .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
        .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
        .TRISTATE_WIDTH(1)      // 3-state converter width (1,4)
    )
    OSERDESE2_SLAVE (
        .CLK        (clk_5x),            // 1-bit input: High speed clock
        .CLKDIV     (clk_1x),            // 1-bit input: Divided clock
        .RST        (~sys_rst_n),             // 1-bit input: Reset
        .OCE        (1'b1),              // 1-bit input: Output data clock enable

        .OQ         (),          // 1-bit output: Data path output
        // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
        .D1         (1'b0),
        .D2         (1'b0),
        .D3         (par_data[8]),
        .D4         (par_data[9]),
        .D5         (1'b0),
        .D6         (1'b0),
        .D7         (1'b0),
        .D8         (1'b0),

        // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
        .SHIFTIN1   (),
        .SHIFTIN2   (),
        // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
        .SHIFTOUT1  (cascade1),
        .SHIFTOUT2  (cascade2),

        //以下信号未使用
        .OFB        (),             // 1-bit output: Feedback path for data 
        // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
        .T1         (1'b0),
        .T2         (1'b0),
        .T3         (1'b0),
        .T4         (1'b0),
        .TBYTEIN    (1'b0),         // 1-bit input: Byte group tristate
        .TCE        (1'b0),         // 1-bit input: 3-state clock enable
        .TBYTEOUT   (),             // 1-bit output: Byte group tristate
        .TFB        (),             // 1-bit output: 3-state control
        .TQ         ()              // 1-bit output: 3-state control        
    );

//单端数据转差分
    OBUFDS #(
        .IOSTANDARD ("TMDS_33")         // Specify the output I/O standard
    ) OBUFDS_TMDS (
        .O          (ser_data_p),       // Diff_p output (connect directly to top-level port)
        .OB         (ser_data_n),       // Diff_n output (connect directly to top-level port)
        .I          (ser_data)          // Buffer input
    );
endmodule
