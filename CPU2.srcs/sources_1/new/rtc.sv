module rtc#(
    parameter CLK_FREQ_HZ = 50000000,  // 系统时钟频率（默认 50MHz）
//   parameter CNT_END     = (CLK_FREQ_HZ / 1000000 )
    parameter CNT_END     = (CLK_FREQ_HZ / 1000000 )     //10us
  )(
    input               clock,
    input               reset,
    input       [31:0]  Addr,
    output reg  [31:0]  run_time
    );
//----------------------------参数定义------------------------------------------
    localparam RTC_BASE = 32'ha0000048;
    localparam RTC_SIZE = 2 * 4; 
    localparam RTC_END  = RTC_BASE + RTC_SIZE - 1;

    wire    [0:0] addra_word = (Addr - RTC_BASE)>>2;
//-----------------------------------------------------------------------------
    //----------------------------计时器--------------------------------
    localparam CLK_CNT_WIDTH = $clog2(CNT_END);

    reg [CLK_CNT_WIDTH-1:0] clk_cnt;
    reg [63:0] time_us;                 //足够大，可以运行很久

    always @(posedge clock) begin
        if(reset) begin
            clk_cnt <= 0;
            time_us <= 0;
        end else begin
            if (clk_cnt == CNT_END - 1) begin
                clk_cnt <= 0;
                time_us <= time_us + 1;
            end else begin
                clk_cnt <= clk_cnt + 1;
            end
        end
    end
    //----------------------------读取----------------------------------
    wire [31:0]  run_time_t;
    assign run_time_t = addra_word ? time_us[63:32] : time_us[31:0]; //addra_word=1表示A000004C，addra_word=0表示A0000048
    always @(posedge clock) begin
        run_time <= run_time_t;
    end
    


endmodule
