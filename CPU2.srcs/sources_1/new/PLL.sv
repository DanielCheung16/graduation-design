module PLL(
    // Clock out ports
    output        clk_parallel,
    output        clk_serial,
    output        clk_200m,
    output        clk_400m,
    output        clk_50m,
    // Status and control signals
    input         rst_n,
    output        sys_rst_n,            //use as reset signal of system after Synchronized Asynchronous Reset
    output        sys_rst_cpu,
    // Clock in ports
    input         clk_in1_p,
    input         clk_in1_n
    );
    
//*****************************************************************
//      Internal Signals
//*****************************************************************
	reg sysrst_nr1, sysrst_nr2;
    reg sysrst_r3, sysrst_r4;
	wire locked;		//输出信号有效标志，高表示PLL输出有效
	wire sysrst_nr0;

//*****************************************************************
//      Main part
//*****************************************************************
    clk_pll2 my_clk_pll2_0
    (
        // Clock out ports
        .clk_200m(clk_200m),     // output clk_200m
        .clk_400m(clk_400m),     // output clk_400m
        .clk_50m(clk_50m),
        // Status and control signals
        .reset(~rst_n), // input reset
        // Clock in ports
        .clk_in1_p(clk_in1_p),    // input clk_in1_p
        .clk_in1_n(clk_in1_n));    // input clk_in1_n

    clk_pll my_clk_pll_0
    (
        // Clock out ports
        .clk_parallel(clk_parallel),     
        .clk_serial(clk_serial),     
        // Status and control signals
        .reset(~rst_n),                //*PLL的复位信号高电平有效
        .locked(locked),       
        // Clock in ports
        .clk_in1(clk_200m));    
  

    // The Synchronized Asynchronous Reset
    assign sysrst_nr0 = rst_n & locked;

    always @(posedge clk_parallel or negedge sysrst_nr0) begin
        if (!sysrst_nr0) begin
            sysrst_nr1 <= 1'b0;
            sysrst_nr2 <= 1'b0;
        end else begin
            sysrst_nr1 <= 1'b1;
            sysrst_nr2 <= sysrst_nr1;
        end
    end
    //*****************
    always @(posedge clk_50m or negedge sysrst_nr0) begin    //CPU复位信号
        if (!sysrst_nr0) begin
            sysrst_r3 <= 1'b1;
            sysrst_r4 <= 1'b1;
        end else begin
            sysrst_r3 <= 1'b0;
            sysrst_r4 <= sysrst_r3;
        end
    end
    
    assign sys_rst_n = sysrst_nr2;              //信号sys_rst_n作为新的系统复位信号，后续可用作异步复位
    assign sys_rst_cpu = sysrst_r4;
endmodule

