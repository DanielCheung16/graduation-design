`timescale 1ns / 1ps
module cpu_test2(

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
        #(CLK_PERIOD_100);
        reset = 0;
    end
    //-----------------------------------------------------------------------

    top u_top(
        .clock_cpu                             	(clk_100m                              ),
        .rst_cpu                             	(reset                              )
    );
    
endmodule
