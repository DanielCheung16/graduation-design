module top(
    input               clk_n             ,   //系统时钟，200MHz
    input               clk_p             ,
    input               rst_n             ,   //复位,低有效             
    //HDMI
    output wire         tmds_clk_p ,
    output wire         tmds_clk_n , //HDMI时钟差分信号
    output wire [2:0]   tmds_data_p ,
    output wire [2:0]   tmds_data_n, //HDMI图像差分信号
    //PS2
    input  wire         up,
    input  wire         down,
    input  wire         left,
    input  wire         right,
    // input  wire         ps2_clk,
    // input  wire         ps2_data,
    //led
    output              led_rst,
    output      [3:0]   led_key
    );
//*****************************************************************
//      Internal Signals
//*****************************************************************
    //PLL
    wire                clk_75m;
    wire                clk_375m;
    wire                clk_50m;
    wire                clk_200m;
    wire                clk_400m;

    wire                sys_rst_n;
    wire                sys_rst_cpu;

    //vga2hdmi  ---- fb
    wire [16:0]     addrb_vga;
    wire [3:0]      web_vga_ctrl;
    wire [0:0]      addrb_vga_ctrl;
    wire [31:0]     dinb_vga_ctrl;
    //fb  ---- vga2hdmi
    wire [31:0]     fb_data;
    wire [31:0]     ctrl_data;
    //vga2hdmi   ----   hdmi
    wire [23:0]     pixel_data;
    //hdmi       ----   vga2hdmi
    wire            data_req;
    wire [10:0]     display_xpos;
    wire [10:0]     display_ypos;

//*****************************************************************
//      Main part
//*****************************************************************    
    
    PLL u_PLL(
        .clk_parallel 	(clk_75m        ),
        .clk_serial   	(clk_375m       ),
        .clk_200m     	(clk_200m       ),
        .clk_400m     	(clk_400m       ),
        .clk_50m      	(clk_50m        ),
        .rst_n        	(rst_n          ),
        .sys_rst_n    	(sys_rst_n      ),
        .sys_rst_cpu  	(sys_rst_cpu    ),
        .clk_in1_p    	(clk_p          ),
        .clk_in1_n    	(clk_n          )
    );
    
    core u_core(
        .clock_cpu      	(clk_50m         ),
        .rst_cpu        	(sys_rst_cpu     ),
        .clock_vga      	(clk_75m         ),
        //vga & ctrl
        .addrb_vga      	(addrb_vga       ),
        .doutb_vga      	(fb_data         ),
        .web_vga_ctrl   	(web_vga_ctrl    ),
        .addrb_vga_ctrl 	(addrb_vga_ctrl  ),
        .dinb_vga_ctrl  	(dinb_vga_ctrl   ),
        .doutb_vga_ctrl 	(ctrl_data       ),
        //keyboard
        //一下都还未接线：
        .up             	(up              ),
        .down           	(down            ),
        .left           	(left            ),
        .right          	(right           )
        // .ps2_clk        	(ps2_clk         ),
        // .ps2_data       	(ps2_data        )
    );
    
    vga2hdmi u_vga2hdmi(
        //面向core
        .clock_vga      	(clk_75m       ),
        .reset          	(~sys_rst_n           ),
        .addrb_vga      	(addrb_vga       ),
        .doutb_vga      	(fb_data       ),
        .web_vga_ctrl   	(web_vga_ctrl    ),
        .addrb_vga_ctrl 	(addrb_vga_ctrl  ),
        .dinb_vga_ctrl  	(dinb_vga_ctrl   ),
        .doutb_vga_ctrl 	(ctrl_data  ),
        //面向HDMI
        .data_req       	(data_req        ),
        .display_xpos   	(display_xpos    ),
        .display_ypos   	(display_ypos    ),
        .pixel_data     	(pixel_data      )
    );
    
    
    HDMI_top u_HDMI_top(
        //input
        .clk_1x       	(clk_75m        ),
        .clk_5x       	(clk_375m        ),
        .sys_rst_n    	(sys_rst_n     ),
        //output
        .tmds_clk_p   	(tmds_clk_p    ),
        .tmds_clk_n   	(tmds_clk_n    ),
        .tmds_data_p  	(tmds_data_p   ),
        .tmds_data_n  	(tmds_data_n   ),
        //from  vga2hdmi
        .pixel_data   	(pixel_data    ),
        //to    vga2hdmi
        .data_req     	(data_req      ),
        .display_xpos 	(display_xpos  ),
        .display_ypos 	(display_ypos  )
    );
//---------------------------DEBUG--------------------------------
    assign led_rst = sys_rst_cpu;
    assign led_key[0] = up;
    assign led_key[1] = down;
    assign led_key[2] = left;
    assign led_key[3] = right;
endmodule
