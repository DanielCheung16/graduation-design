module virtual_ky(
    input   clk_cpu,
    input   rst,
    input   up,
    input   down,
    input   left,
    input   right,

    input   wire mmio_en,
    input   wire [31:0] addra,
    output  wire [31:0] data_out  
    );

//----------------------------参数定义--------------------------------------------------
    localparam KY_BASE  = 32'ha0000060;

    localparam CLK_FREQ_HZ = 50000000; // 系统时钟频率（默认 50MHz）
    localparam PS2_CLK_PERIOD = 20000; // 20kHz PS/2 时钟 -> 50us周期
    localparam CNT_END = CLK_FREQ_HZ/PS2_CLK_PERIOD;      // 50MHz的clk_cpu数2500个周期

    parameter UP = 8'h1D;
    parameter DOWN = 8'h1B;
    parameter LEFT = 8'h1C;
    parameter RIGHT = 8'h23;

    reg [3:0]   bit_cnt;
    reg [10:0]  shift_data;
    reg         up_received0,up_received1;
    reg         down_received0,down_received1;
    reg         left_received0,left_received1;
    reg         right_received0,right_received1;

    wire      up_key_down, down_key_down, left_key_down, right_key_down;
    wire      up_key_up, down_key_up, left_key_up, right_key_up;    

    //fifo
    wire        full;
    wire        empty;
    reg         wr_en;
    reg [8:0]  fifo_din; 
//--------------------------------------------------------------------------------------
//检测每一个按键是否按下和松开
    always @(posedge clk_cpu) begin
        if(rst) begin
            up_received0 <= 0;
            up_received1 <= 0;

            down_received0 <= 0;
            down_received1 <= 0;

            left_received0 <= 0;
            left_received1 <= 0;

            right_received0 <= 0;
            right_received1 <= 0;            
        end else begin
            up_received0 <= up;
            up_received1 <= up_received0;

            down_received0 <= down;
            down_received1 <= down_received0;

            left_received0 <= left;
            left_received1 <= left_received0;

            right_received0 <= right;
            right_received1 <= right_received0;
        end
    end

    assign up_key_down = up_received0 & ~up_received1;
    assign up_key_up = ~up_received0 & up_received1;
    assign down_key_down = down_received0 & ~down_received1;
    assign down_key_up  = ~down_received0 & down_received1;
    assign left_key_down = left_received0 & ~left_received1;
    assign left_key_up = ~left_received0 & left_received1;
    assign right_key_down = right_received0 & ~right_received1;
    assign right_key_up = ~right_received0 & right_received1;

    wire   [3:0]   send_valid = {up_key_down,down_key_down,left_key_down,right_key_down};
    wire   [3:0]   send_f0_valid = {up_key_up,down_key_up,left_key_up,right_key_up};

    wire        scan_valid1, scan_valid2;
    assign scan_valid1   = send_valid && !full;     //ps2来信号了，且fifo不满
    assign scan_valid2   = send_f0_valid && !full;     //ps2来信号了，且fifo不满

    always @(posedge clk_cpu) begin
        if(rst) begin
            fifo_din  <= 0;
            wr_en <= 0;
        end else begin
            if(scan_valid1) begin
                case (send_valid)
                    4'b1000:    fifo_din <= {1'b0, UP} ;
                    4'b0100:    fifo_din <= {1'b0, DOWN};
                    4'b0010:    fifo_din <= {1'b0, LEFT};
                    4'b0001:    fifo_din <= {1'b0, RIGHT};
                    default:    begin
                                    fifo_din <= 9'b1_0000_0000; //key_up的
                                    wr_en <= 0;
                                end
                endcase
                wr_en <= 1;
            end else if (scan_valid2) begin
                case (send_f0_valid)
                    4'b1000:    fifo_din <= {1'b1, UP} ;
                    4'b0100:    fifo_din <= {1'b1, DOWN};
                    4'b0010:    fifo_din <= {1'b1, LEFT};
                    4'b0001:    fifo_din <= {1'b1, RIGHT};
                    default:    begin
                                    fifo_din <= 9'b1_0000_0000; //key_up的
                                    wr_en <= 0;
                                end
                endcase                
                wr_en <= 1;
            end else begin
                fifo_din <= 9'b1_0000_0000;
                wr_en <= 0;
            end
        end
    end

    //读
    wire    [8:0]   fifo_dout;
    reg     [31:0]  douta_t;
    reg             rd_en;
    always @(posedge clk_cpu) begin
        if(rst) begin
            douta_t <= 0;
            rd_en   <= 0;
        end else begin
            if(!empty && mmio_en && addra == KY_BASE) begin             //请求读，且fifo不为空；
                douta_t <= fifo_dout[8] ? {24'h0, fifo_dout[7:0]} : {24'h000080, fifo_dout[7:0]} ;
                rd_en   <= 1;
            end else begin
                douta_t <= 0;
                rd_en   <= 0;
            end
        end
    end
    //--------------------------------------例化----------------------------------------
    ps2_fifo_0 u_ps2_fifo_0(
        .rst    	(rst      ),
        .wr_clk 	(clk_cpu    ),
        .rd_clk 	(clk_cpu    ),
        .din    	(fifo_din   ),
        .wr_en  	(wr_en      ),
        .rd_en  	(rd_en      ),
        .dout   	(fifo_dout  ),
        .full   	(full       ),
        .empty  	(empty      )
    );
    //---------------------------CPU端读取数据-----------------------------------
    reg [31:0] addra1;
    always @(posedge clk_cpu) begin                   //addra_offset会决定输出的调整
        if(rst)begin
            addra1 <= 0;
        end else begin
            addra1    <=  addra;
        end
    end

    assign data_out = (addra1 == KY_BASE)? douta_t : 32'h0;
endmodule
