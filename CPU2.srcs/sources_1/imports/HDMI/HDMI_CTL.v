`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/20 16:11:17
// Design Name: 
// Module Name: HDMI_CTL
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HDMI_CTL(
    input wire          clk_1x ,        //输入系统时钟
    input wire          clk_5x ,        //输入5倍系统时钟
    input wire          sys_rst_n ,     //复位信号,低有效
    input wire [7:0]    rgb_blue ,      //蓝色分量
    input wire [7:0]    rgb_green ,     //绿色分量
    input wire [7:0]    rgb_red ,       //红色分量
    input wire          hsync ,         //行同步信号
    input wire          vsync ,         //场同步信号
    input wire          de ,            //使能信号

    output wire         hdmi_clk_p ,
    output wire         hdmi_clk_n ,    //时钟差分信号
    output wire         hdmi_r_p ,
    output wire         hdmi_r_n ,      //红色分量差分信号
    output wire         hdmi_g_p ,
    output wire         hdmi_g_n ,      //绿色分量差分信号
    output wire         hdmi_b_p ,
    output wire         hdmi_b_n        //蓝色分量差分信号
);

//*****************************************************************
//      Internal Signals
//*****************************************************************
    wire [9:0] red ;    //8b转10b后的红色分量
    wire [9:0] green ;  //8b转10b后的绿色分量
    wire [9:0] blue ;   //8b转10b后的蓝色分量

//*****************************************************************
//      Instantiate
//*****************************************************************
//------------- encoder_inst0 -------------
    Encoder encoder_inst0
    (
        .sys_clk (clk_1x ),
        .sys_rst_n (sys_rst_n ),
        .data_in (rgb_blue ),
        .c0 (hsync ),
        .c1 (vsync ),
        .de (de ),
        .data_out (blue )
    );

//------------- encoder_inst1 -------------
    Encoder encoder_inst1
    (
        .sys_clk (clk_1x ),
        .sys_rst_n (sys_rst_n ),
        .data_in (rgb_green ),
        .c0 (1'b0 ),
        .c1 (1'b0 ),
        .de (de ),
        .data_out (green )
    );

//------------- encoder_inst2 -------------
    Encoder encoder_inst2
    (
        .sys_clk (clk_1x ),
        .sys_rst_n (sys_rst_n ),
        .data_in (rgb_red ),
        .c0 (1'b0 ),
        .c1 (1'b0 ),
        .de (de ),
        .data_out (red )
    );

//------------- par_to_ser_inst0 -------------
    Serializer par_to_ser_inst0
    (
        .sys_rst_n(sys_rst_n),
        .clk_1x(clk_1x),
        .clk_5x (clk_5x ),
        .par_data (blue ),

        .ser_data_p (hdmi_b_p ),
        .ser_data_n (hdmi_b_n )
    );

//------------- par_to_ser_inst1 -------------
    Serializer par_to_ser_inst1
    (
        .sys_rst_n(sys_rst_n),
        .clk_1x(clk_1x),
        .clk_5x (clk_5x ),
        .par_data (green ),

        .ser_data_p (hdmi_g_p ),
        .ser_data_n (hdmi_g_n )
    );

//------------- par_to_ser_inst2 -------------
    Serializer par_to_ser_inst2
    (
        .sys_rst_n(sys_rst_n),
        .clk_1x(clk_1x),
        .clk_5x (clk_5x ),
        .par_data (red ),

        .ser_data_p (hdmi_r_p ),
        .ser_data_n (hdmi_r_n )
    );

//------------- par_to_ser_inst3 -------------
    Serializer par_to_ser_inst3
    (
        .sys_rst_n(sys_rst_n),
        .clk_1x(clk_1x),
        .clk_5x (clk_5x ),
        .par_data (10'b1111100000 ),

        .ser_data_p (hdmi_clk_p ),
        .ser_data_n (hdmi_clk_n )
    );

endmodule
