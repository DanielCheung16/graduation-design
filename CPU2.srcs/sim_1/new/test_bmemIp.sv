`timescale 1ns / 1ps
module test_bmemIp(

    );
    parameter CLK_PERIOD_100 = 100; // 周期为 100ns

    // Inputs
    reg clk_100m;
    reg reset;
    // output declaration of module vga_gen_0
    wire [31:0] douta;
    reg [3:0]   wea;
    reg [16:0]  addra;
    reg [31:0]  dina;

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

    initial begin
        //load:
        wea = 4'b0000;      
        addra = 17'b0;
        dina = 1;
        // #(CLK_PERIOD_100/2)
        #CLK_PERIOD_100
        addra = addra+ 1;   //把addrb和addra的更新放一起是为了看addrb在addra写的时候读出来什么数据
        repeat (5) begin
            #CLK_PERIOD_100;
            addra = addra + 1;;
        end

        //store:
        //sw
        wea = 4'b1111;      //word四个byte都写
        dina = 32'hffffffff;
        #CLK_PERIOD_100;
        addra = addra + 1;
        //sb
        wea = 4'b0001;      //写低位
        dina = 32'hffffffff;
        #CLK_PERIOD_100;
        addra = addra + 1;

        repeat (3)begin
            wea = wea<<1;
            #CLK_PERIOD_100;
            addra = addra + 1;
        end
        //sh
        wea = 4'b0011;      //写低位
        dina = 32'hffffffff;
        #CLK_PERIOD_100;
        addra = addra + 1;

        repeat (2)begin
            wea = wea<<1;
            #CLK_PERIOD_100;
            addra = addra + 1;
        end

    end

    
    
    bmem_ip u_bmem_ip(
        .clka  	(clk_100m   ),
        .ena   	(1          ),
        .wea   	(wea    ),
        .addra 	(addra  ),
        .dina  	(dina   ),
        .douta 	(douta  )
    );
    
    
    
endmodule
