//////////////////////////////////////////////////////////////////////////////////
// Dependencies: 从fb显存部分得到数据，给到hdmi模块
//////////////////////////////////////////////////////////////////////////////////

module vga2hdmi(
    input               clock_vga,
    input               reset,
    //CPU方向
    output       [16:0]  addrb_vga,
    input        [31:0]  doutb_vga,             //fb读出的数据

    output  wire  [3:0]  web_vga_ctrl,          //当前是否写
    output  wire  [0:0]  addrb_vga_ctrl,        //实际地址
    output  wire  [31:0] dinb_vga_ctrl,         //读完一帧需要拉0
    input   wire  [31:0] doutb_vga_ctrl,        //cpu跟新fb标志位
    //HDMI方向
    input   wire         data_req,
    input   wire  [10:0] display_xpos,
    input   wire  [10:0] display_ypos,
    output  reg   [23:0] pixel_data
    );
//----------------------------参数定义------------------------------------------
    localparam X_BASE   = 441;  //(1280-400)/2 = 440
    localparam X_END    = 840;
    localparam Y_BASE   = 211;  //(720-300)/2 = 210
    localparam Y_END    = 510;  
//-----------------------------------------------------------------------------   
//----------------------------简化信号名------------------------------------------
    wire          fb_valid;
    wire   [23:0] fb_data;

    assign  fb_valid = (doutb_vga_ctrl == 32'd1) ? 1'b1: 1'b0;
    assign  fb_data  = doutb_vga;
//-----------------------------------------------------------------------------    
    wire    x_valid;
    assign  x_valid = (display_xpos >= X_BASE && display_xpos <= X_END)? 1'b1: 1'b0;
    wire    y_valid;
    assign  y_valid = (display_ypos >= Y_BASE && display_ypos <= Y_END)? 1'b1: 1'b0;
    wire    xy_valid;
    assign  xy_valid = x_valid && y_valid;

    reg     [16:0]  vga_addr;
//------------------------------------------------------------------------------
    assign addrb_vga_ctrl = 1;                  //是mmio中vga_ctrl的物理地址。映射地址是0xa0000104
    assign  addrb_vga = vga_addr;

    always @(*) begin
        if (xy_valid && fb_valid && data_req) begin
            vga_addr = ((display_ypos - Y_BASE) * 400) + (display_xpos - X_BASE);
        end else begin
            vga_addr = 17'h0;
        end
    end

    always @(*) begin
        if (xy_valid && fb_valid && data_req) begin
            pixel_data = fb_data[23:0];
        end else begin
            pixel_data = 24'h0;                 //黑色
        end
    end

    wire frame_end;
    assign frame_end = (display_xpos == X_END) && (display_ypos == Y_END) && data_req;

    reg sync_clear;

    always @(posedge clock_vga) begin
        if (reset) begin
            sync_clear <= 0;
        end else if (frame_end) begin
            sync_clear <= 1;
        end else begin
            sync_clear <= 0;
        end
    end

    assign web_vga_ctrl  = sync_clear ? 4'b0000 : 4'b0000;  //修改1sync_clear ? 4'b1111 : 4'b0000;
    assign dinb_vga_ctrl = 32'h0;

    // reg [3:0] web_cnt;
    // always @(posedge clock_vga) begin       // 拉高10个周期清除信号，
    //     if (reset) begin
    //         web_cnt <= 0;
    //     end else begin
    //         if(frame_end) 
    //             web_cnt <= 10; 
    //         else if(web_cnt != 0)
    //             web_cnt <= web_cnt - 1;
    //         else
    //             web_cnt <= 0;
    //     end  
    // end
    // assign web_vga_ctrl = (web_cnt != 0) ? 4'b1111 : 4'b0000;
endmodule
