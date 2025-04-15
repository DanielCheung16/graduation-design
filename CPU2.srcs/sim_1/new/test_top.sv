`timescale 1ns / 1ps

module test_top;

    //*****************************************************************
    // Parameter Definitions
    //*****************************************************************
    parameter CLK_PERIOD = 5; // 200MHz 时钟 -> 5ns周期
    parameter PS2_CLK_PERIOD = 500000; // 20kHz PS/2 时钟 -> 50us周期

    //*****************************************************************
    // Signal Declarations
    //*****************************************************************
    // Inputs
    reg clk_p;
    reg clk_n;
    reg rst_n;
    reg ps2_clk;
    reg ps2_data;

    // Outputs
    wire tmds_clk_p;
    wire tmds_clk_n;
    wire [2:0] tmds_data_p;
    wire [2:0] tmds_data_n;

    //*****************************************************************
    // Clock Generation (Differential)
    //*****************************************************************
    initial begin
        clk_p = 1'b0;
        clk_n = 1'b1;
        forever begin
            #(CLK_PERIOD / 2) clk_p = ~clk_p;
            clk_n = ~clk_p;
        end
    end

    //*****************************************************************
    // Reset Generation
    //*****************************************************************
    initial begin
        rst_n = 1'b0;
        #100000;
        rst_n = 1'b1;
    end

    //*****************************************************************
    // PS/2 Send Task (send 11-bit word: start + 8 data + parity + stop)
    //*****************************************************************
    task send_ps2_byte(input [7:0] data_byte);
        integer i;
        reg parity;
        begin
            // Calculate odd parity
            parity = ~^data_byte;

            // Start bit (0)
            ps2_data = 0;
            drive_ps2_clk();

            // 8 data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                ps2_data = data_byte[i];
                drive_ps2_clk();
            end

            // Parity bit
            ps2_data = parity;
            drive_ps2_clk();

            // Stop bit (1)
            ps2_data = 1;
            drive_ps2_clk();

            // 结束后，恢复空闲状态
            ps2_data = 1;
            #(10 * PS2_CLK_PERIOD); // 间隔一段时间
        end
    endtask

    // 模拟 PS/2 的一个完整的时钟周期（下降沿驱动）
    task drive_ps2_clk;
        begin
            ps2_clk = 1;
            #(PS2_CLK_PERIOD / 2);
            ps2_clk = 0;
            #(PS2_CLK_PERIOD / 2);
        end
    endtask

    //*****************************************************************
    // PS/2 数据仿真
    //*****************************************************************
    initial begin
        ps2_clk  = 1;
        ps2_data = 1;

        @(posedge rst_n);
        #500000000; // 稍微等待系统稳定

        // 发送几个按键测试值，例如 ‘A’ 键的扫描码为 0x1C
        send_ps2_byte(8'h1C); // 按下 A
        send_ps2_byte(8'hF0); // 释放码前缀
        send_ps2_byte(8'h1C); // 释放 A

        send_ps2_byte(8'h45); // 按下 NumLock
        send_ps2_byte(8'hF0);
        send_ps2_byte(8'h45); // 释放 NumLock
    end

    //*****************************************************************
    // DUT
    //*****************************************************************
    top u_top(
        .clk_n       	(clk_n        ),
        .clk_p       	(clk_p        ),
        .rst_n       	(rst_n        ),
        .tmds_clk_p  	(tmds_clk_p   ),
        .tmds_clk_n  	(tmds_clk_n   ),
        .tmds_data_p 	(tmds_data_p  ),
        .tmds_data_n 	(tmds_data_n  ),
        .ps2_clk     	(ps2_clk      ),
        .ps2_data    	(ps2_data     )
    );

endmodule
