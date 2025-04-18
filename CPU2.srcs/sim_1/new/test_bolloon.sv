`timescale 1ns / 1ns


module test_bolloon();
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
    reg A,D,J,I;

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
    task pick_A;
        begin
            A = 1;
            #(PS2_CLK_PERIOD / 2);
            A = 0;
            #(PS2_CLK_PERIOD / 2);
        end
    endtask
        task pick_D;
        begin
            D = 1;
            #(PS2_CLK_PERIOD / 2);
            D = 0;
            #(PS2_CLK_PERIOD / 2);
        end
    endtask
        task pick_J;
        begin
            J = 1;
            #(PS2_CLK_PERIOD / 2);
            J = 0;
            #(PS2_CLK_PERIOD / 2);
        end
    endtask
        task pick_I;
        begin
            I = 1;
            #(PS2_CLK_PERIOD / 2);
            I = 0;
            #(PS2_CLK_PERIOD / 2);
        end
    endtask

    //*****************************************************************
    // PS/2 数据仿真
    //*****************************************************************
    initial begin
        A = 0;
        D = 0;
        J = 0;
        I = 0;

        @(posedge rst_n);
        #500000000; // 稍微等待系统稳定

        // 发送几个按键测试值
        pick_A;
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
        .up             (J),
        .down           (I),
        .left           (A),
        .right          (D)
    );
    
endmodule