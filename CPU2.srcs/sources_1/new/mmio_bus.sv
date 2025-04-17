
//////////////////////////////////////////////////////////////////////////////////
// Dependencies: 包含dmem，vga，keyboard的映射。同时面向cpu和device
/* Device Addr:
        KBD_ADDR 0xa0000060
        VGA_ADDR 0xa0000100
        DMEM     0x80000000
*/
//////////////////////////////////////////////////////////////////////////////////

module mmio_bus(
    //to cpu
    input               clock_cpu,
    input               rst_cpu,
    input       [31:0]  Addr_cpu,
    input       [31:0]  WD_cpu,
    input               WE_cpu,
    input       [1:0]   LEN_cpu,
    output reg  [31:0]  dout_cpu,
    //to vga
    input               clock_vga,
    input       [16:0]  addrb_vga,
    output      [31:0]  doutb_vga,
    //to vga_ctrl
    input  wire  [3:0]  web_vga_ctrl,
    input  wire  [0:0]  addrb_vga_ctrl,
    input  wire  [31:0] dinb_vga_ctrl,
    output wire  [31:0] doutb_vga_ctrl,
    //to keyboard
    input  wire         up,
    input  wire         down,
    input  wire         left,
    input  wire         right
    // input   wire        ps2_clk,
    // input   wire        ps2_data
    );
//-------------------------------------地址映射-----------------------------------
    localparam FB_BASE = 32'ha1000000;
    localparam FB_SIZE = 400 * 300 * 4;//weight:400, hight:300, 以Byte为单位所以*4
    localparam FB_END  = FB_BASE + FB_SIZE - 1;
    localparam VGA_CTRL_BASE = 32'ha000_0100;
    localparam VGA_CTRL_SIZE = 8;
    localparam VGA_CTRL_END  = VGA_CTRL_BASE + VGA_CTRL_SIZE -1;
    localparam KY_BASE  = 32'ha0000060;
    localparam KY_SIZE  = 4;
    localparam KY_END   = KY_BASE + KY_SIZE -1;
    localparam DMEM_BASE = 32'h80000000;
    localparam DMEM_SIZE = 16'h4000 * 4; // 16384*4 = 64KB
    localparam DMEM_END  = DMEM_BASE + DMEM_SIZE - 1;
    localparam RTC_BASE = 32'ha0000048;
    localparam RTC_SIZE = 2 * 4; 
    localparam RTC_END  = RTC_BASE + RTC_SIZE - 1;

    //-----------------vga--------------------
    // output declaration of module vga_gen_0
    wire [31:0] douta_vga;
    // input declaration of module  vga_gen_0
    wire [3:0]   wea_vga;

    //-----------------vga_ctrl---------------
    //input
    wire    [3:0]   wea_vga_ctrl;
    //output
    wire    [31:0] douta_vga_ctrl;

    //-----------------dmem------------------
    wire    [3:0]   wea_dmem;
    wire    [31:0]  douta_dmem;
    //-----------------rtc-------------------
    wire    [31:0] run_time;
    //-----------------keyborad--------------
    //in
    wire    mmio_en;
    //out
    wire    [31:0] dout_ky;
//--------------------------------------------------
    localparam DEVICE_NUM = 5;
    localparam NONE     = 5'b0;
    localparam DMEM     = 5'b00001;
    localparam FB       = 5'b00010;
    localparam VGA_CTRL = 5'b00100;
    localparam KEYBOARD = 5'b01000;
    localparam RTC      = 5'b10000;

    reg [3:0]   we_t;
    wire [1:0]  byte_offset;    //方便书写we_t
    reg [DEVICE_NUM - 1:0]   device_num;    //由DMEM，VGA，KEYBOARD进行编码    

    assign byte_offset = Addr_cpu[1:0]; 

    always @(*) begin
        if(WE_cpu) begin
            case (LEN_cpu)
                2'b00: we_t = 4'b0001 << byte_offset;// SB
                2'b01: we_t = 4'b0011 << byte_offset;// SH
                2'b10: we_t = 4'b1111;               //SW
                default: we_t = 4'b1111;
            endcase
        end else begin
            we_t = 4'b0;
        end
    end 

    //判断使用哪一个device
    always @(*) begin
        if (Addr_cpu >= KY_BASE && Addr_cpu <= KY_END) begin     //32bits的数据
            device_num = KEYBOARD;
        end else if (Addr_cpu >= VGA_CTRL_BASE && Addr_cpu <= VGA_CTRL_END) begin
            device_num = VGA_CTRL;
        end else if (Addr_cpu >= FB_BASE    && (Addr_cpu <= FB_END)) begin    //这里与显存大小有关
            device_num = FB;
        end else if (Addr_cpu >= DMEM_BASE  && (Addr_cpu <= DMEM_END))begin
            device_num = DMEM;
        end else if (Addr_cpu >= RTC_BASE   && (Addr_cpu <= RTC_END))begin
            device_num = RTC;
        end else begin
            device_num = NONE;
        end
    end

    //-----------------------vga(fb)部分--------------------------------------------------
    assign wea_vga = device_num[1]? we_t:   4'b0;           //vga(fb)的写使能
    
    vga_fb u_vga_fb(
        .clock_cpu 	(clock_cpu  ),
        .clock_vga 	(clock_vga  ),
        .rst_cpu   	(rst_cpu    ),
        .wea       	(wea_vga    ),
        .addra     	(Addr_cpu   ),
        .dina      	(WD_cpu     ),
        .addrb     	(addrb_vga  ),//device端
        .douta     	(douta_vga  ),
        .doutb     	(doutb_vga  )//device端
    );

    //-----------------------vga_ctrl部分-------------------------------------------------
    assign wea_vga_ctrl = device_num[2]? we_t:  4'b0;
    
    vga_ctrl u_vga_ctrl(
        .clock_cpu 	(clock_cpu      ),
        .rst_cpu   	(rst_cpu        ),
        .wea       	(wea_vga_ctrl   ),
        .addra     	(Addr_cpu       ),
        .dina      	(WD_cpu         ),
        .douta     	(douta_vga_ctrl ),
        .clock_vga 	(clock_vga      ),  //device端
        .web       	(web_vga_ctrl   ),
        .addrb     	(addrb_vga_ctrl ),
        .dinb      	(dinb_vga_ctrl  ),
        .doutb     	(doutb_vga_ctrl )
    );
    
    //---------------------------dmem部分-------------------------------------------------
    assign  wea_dmem = device_num[0] ? we_t : 4'b0;
    
    dmem u_dmem(
        .clock_cpu 	(clock_cpu  ),
        .rst_cpu   	(rst_cpu    ),
        .wea       	(wea_dmem   ),
        .addra     	(Addr_cpu   ),
        .dina      	(WD_cpu     ),
        .douta     	(douta_dmem )
    );
    //---------------------------rtc部分-------------------------------------------------
    rtc u_rtc(
        .clock    	(clock_cpu      ),
        .reset    	(rst_cpu        ),
        .Addr     	(Addr_cpu       ),
        .run_time 	(run_time  )
    );
    //---------------------------keyboard部分--------------------------------------------
    assign  mmio_en = device_num[3];

    virtual_ky u_virtual_ky(
        .clk_cpu  	(clock_cpu      ),
        .rst      	(rst_cpu        ),
        .up       	(up             ),
        .down     	(down           ),
        .left     	(left           ),
        .right    	(right          ),
        .mmio_en  	(mmio_en        ),
        .addra    	(Addr_cpu       ),
        .data_out 	(dout_ky        )
    );  
    
    // ky u_ky(
    //     .clk_cpu  	(clock_cpu  ),
    //     .reset    	(rst_cpu    ),
    //     .ps2_clk  	(ps2_clk   ),
    //     .ps2_data 	(ps2_data  ),
    //     .mmio_en  	(mmio_en    ),
    //     .addra    	(Addr_cpu   ),
    //     .data_out 	(dout_ky    )
    // );
    
    
    //--------------------------给CPU返回数据---------------------------------------------
    reg [DEVICE_NUM - 1:0]   device_num1;        //需要将device_num多打一拍
    always @(posedge clock_cpu) begin
        if(rst_cpu) begin
            device_num1 <= 0;
        end else begin
            device_num1 <= device_num;
        end
    end
    always @(*) begin
        case (device_num1)
            DMEM:       dout_cpu = douta_dmem;
            FB:         dout_cpu = douta_vga;
            VGA_CTRL:   dout_cpu = douta_vga_ctrl;
            KEYBOARD:   dout_cpu = dout_ky;
            RTC:        dout_cpu = run_time;
            default:    dout_cpu = 0;
        endcase
    end

endmodule
