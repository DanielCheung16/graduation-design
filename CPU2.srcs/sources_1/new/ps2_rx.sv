module ps2_rx(
    input       wire    clk_cpu,
    input       wire    reset,
    input       wire    ps2_clk,
    input       wire    ps2_data,

    output      wire     [7:0] scan_code,
    output      reg     valid  
    );
//----------------------------参数定义--------------------------------------------------
    reg     ps2_clk_sync0, ps2_clk_sync1;
    wire    ps2_clk_neg;

    reg [3:0]   bit_cnt;
    reg [10:0]  shift_data;
    reg         received0,received1;
//--------------------------------------------------------------------------------------
    always @(posedge clk_cpu) begin               // 将clk_ps2同步到clk_cpu下，延迟一次，从而找出跳变沿
        if (reset) begin
            ps2_clk_sync0 <= 0;
            ps2_clk_sync1 <= 0;
        end else begin
            ps2_clk_sync0 <= ps2_clk;
            ps2_clk_sync1 <= ps2_clk_sync0;
        end
    end
    assign ps2_clk_neg = ps2_clk_sync1 & ~ps2_clk_sync0;

    always @(posedge clk_cpu) begin
        if (reset) begin
            bit_cnt     <= 0;
            shift_data  <= 0;
            received1   <= 0;
            received0   <= 0;
        end else begin
            if(ps2_clk_neg) begin               //遇到下降沿，进行判断
                if(bit_cnt == 10) begin
                    shift_data      <= {ps2_data, shift_data[10:1]};
                    bit_cnt         <= 0;
                    received0       <= 1;           //在下一次收到neg之前都是有效的
                end else begin
                    shift_data      <= {ps2_data, shift_data[10:1]};
                    bit_cnt         <= bit_cnt + 1;
                    received0       <= 0;           
                end
            end
            received1   <= received0;
        end
    end
    assign  valid = ~received1 & received0;
    assign  scan_code = shift_data[8:1];


endmodule
