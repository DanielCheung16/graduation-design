module ky(
    input   wire clk_cpu,
    input   wire reset,
    input   wire ps2_clk,
    input   wire ps2_data,

    input   wire mmio_en,
    input   wire [31:0] addra,
    output  wire [31:0] data_out       
    );
//----------------------------参数定义--------------------------------------------------
    localparam KY_BASE  = 32'ha0000060;
    localparam KY_SIZE  = 4;
    localparam KY_END   = KY_BASE + KY_SIZE -1;
    
    wire           addra_word = (addra - KY_BASE)>>2;    //这里读的地址都是做了地址对齐的（可能会有问题，lh，lb这种可能会出错）
    reg     [1:0]  addra_offset;

    //连接信号
    wire [7:0] scan_code;
    wire valid;
    // output declaration of module ps2_fifo_0
    wire [8:0] dout;
    wire full;
    wire empty;
//--------------------------------------------------------------------------------------
    //---------------------------接收PS2数据，存入fifo---------------------------
    //写
    reg         key_up;     //用于记录是否释放按键
    reg         wr_en;
    reg [8:0]   fifo_din;
    wire        scan_valid;


    assign scan_valid   = valid && !full;     //ps2来信号了，且fifo不满
    always @(posedge clk_cpu) begin
        if (reset) begin
            key_up <= 0;
            wr_en  <= 0;
            fifo_din <= 0;
        end else begin
            if(scan_valid)begin    
                if (scan_code == 8'hf0) begin
                    key_up <= 1;
                end else begin
                    wr_en   <= 1;
                    fifo_din <=  {key_up, scan_code};
                    key_up <= 0;
                end
            end else begin
                wr_en <= 0;             //wr_en只能存在一个脉冲
            end 
        end
    end
    //读
    wire    [8:0]   fifo_dout;
    reg     [31:0]  douta_t;
    reg             rd_en;
    always @(posedge clk_cpu) begin
        if(reset) begin
            douta_t <= 0;
            rd_en   <= 0;
        end else begin
            if(!empty && mmio_en) begin             //请求读，且fifo不为空；
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
        .rst    	(reset      ),
        .wr_clk 	(clk_cpu    ),
        .rd_clk 	(clk_cpu    ),
        .din    	(fifo_din   ),
        .wr_en  	(wr_en      ),
        .rd_en  	(rd_en      ),
        .dout   	(fifo_dout  ),
        .full   	(full       ),
        .empty  	(empty      )
    );
    
    ps2_rx u_ps2_rx(
        .clk_cpu   	(clk_cpu    ),
        .reset     	(reset      ),
        .ps2_clk   	(ps2_clk    ),
        .ps2_data  	(ps2_data   ),
        .scan_code 	(scan_code  ),
        .valid     	(valid      )
    );
    

    //---------------------------CPU端读取数据-----------------------------------
    always @(posedge clk_cpu) begin                   //addra_offset会决定输出的调整
        if(reset)begin
            addra_offset <= 2'b0;
        end else begin
            addra_offset    <=  addra[1:0];
        end
    end

    assign data_out = (addra_offset == 0)? douta_t >> (8*addra_offset): 32'h0;
endmodule

