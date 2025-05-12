`timescale 1ns / 1ps


module test_ky(

    );
    //*****************************************************************
    // Parameter Definitions
    //*****************************************************************
    parameter CLK_PERIOD_CPU = 20;           // 50MHz -> 20ns
    parameter PS2_CLK_PERIOD = 100;      // ~10kHz PS/2 clock

    //*****************************************************************
    // Signal Declarations
    //*****************************************************************
    reg clk_cpu;
    reg reset;
    reg ps2_clk;
    reg ps2_data;
    reg     mmio_en;
    //*****************************************************************
    // Clock Generation
    //*****************************************************************
    always #(CLK_PERIOD_CPU/2) clk_cpu = ~clk_cpu;

    initial begin
        clk_cpu = 1'b0;
        ps2_clk = 1'b1;
    end

    always #(PS2_CLK_PERIOD/2) ps2_clk = ~ps2_clk;
    //*****************************************************************
    // Reset Sequence
    //*****************************************************************
    parameter DATA0 = {2'b11, 8'b0000_1111, 1'b0};//总共10bit
    parameter DATA1 = {2'b10, 8'b1010_1110, 1'b0};//总共10bit
    parameter DATA2 = {2'b11, 8'b0110_0110, 1'b0};//总共10bit
    parameter DATA3 = {2'b11, 8'b0000_0000, 1'b0};//总共10bit
    parameter OVER  = {2'b10, 8'b1111_0000, 1'b0};//总共10bit
    parameter DATA_1C  = {2'b10, 8'h1c, 1'b0};//总共11bit
    parameter DATA_2B  = {2'b10, 8'h2b, 1'b0};//总共11bit
    //------------------------封装的任务函数------------------------
    task send_ps2_data;
        input [10:0] data;  // 11-bit data frame
        input integer repeat_count;
        integer i, j;
        begin
            repeat (repeat_count) begin
                for (i = 0; i < 11; i = i + 1) begin
                    ps2_data = data[i];
                    #PS2_CLK_PERIOD;
                end
            end
        end
    endtask

    task mmio_read;
        input integer repeat_count;
        integer i, j;
        begin
            repeat (repeat_count) begin
                mmio_en = 1'b1;
                #CLK_PERIOD_CPU;
                mmio_en = 1'b0;
            end
        end
    endtask

    initial begin
        reset = 1'b1;
        ps2_clk = 1'b1;
        ps2_data = 1'b1;
        mmio_en  = 1'b0;
        #100;
        reset = 1'b0;
        send_ps2_data(DATA_1C, 1);  // DATA_1C通码
        send_ps2_data(OVER,  1);  // 断码
        send_ps2_data(DATA_1C, 1);  // DATA_1C通码
        send_ps2_data(DATA_2B, 1);  // DATA_2B通码
        repeat(5) begin
            mmio_read(1);             //读取一次
            #(CLK_PERIOD_CPU * 5);
        end
    end
 
    // output declaration of module ky
    wire [31:0] data_out;
    
    ky u_ky(
        .clk_cpu  	(clk_cpu   ),
        .reset    	(reset     ),
        .ps2_clk  	(ps2_clk   ),
        .ps2_data 	(ps2_data  ),
        .mmio_en  	(mmio_en   ),
        .addra    	(32'ha0000060  ),
        .data_out 	(data_out  )
    );
    
    
endmodule

