`timescale 1ns / 1ps

module test_ps2(

    );
    //*****************************************************************
    // Parameter Definitions
    //*****************************************************************
    parameter CLK_PERIOD_CPU = 20;           // 50MHz -> 20ns
    parameter PS2_CLK_PERIOD = 100000;      // ~10kHz PS/2 clock

    //*****************************************************************
    // Signal Declarations
    //*****************************************************************
    reg clk_cpu;
    reg reset;
    reg ps2_clk;
    reg ps2_data;

    wire [7:0] scan_code;
    wire valid;
    
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

    initial begin
        reset = 1'b1;
        ps2_clk = 1'b1;
        ps2_data = 1'b1;
        #100;
        reset = 1'b0;
        repeat(30) begin
            integer i;
            for (i = 0;i < 11 ; i=i+1) begin
                ps2_data  = DATA1[i];
                #PS2_CLK_PERIOD;
            end
        end
    end
 
    ps2_rx u_ps2_rx(
        .clk_cpu   	(clk_cpu    ),
        .reset     	(reset      ),
        .ps2_clk   	(ps2_clk    ),
        .ps2_data  	(ps2_data   ),
        .scan_code 	(scan_code  ),
        .valid     	(valid      )
    );
    
endmodule
