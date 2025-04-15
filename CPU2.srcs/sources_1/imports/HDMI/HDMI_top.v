`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/20 18:37:21
// Design Name: 
// Module Name: HDMI_top
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


module HDMI_top(
    input clk_1x,
    input clk_5x,
    input sys_rst_n,

    output wire tmds_clk_p ,
    output wire tmds_clk_n , //HDMI时钟差分信号
    output wire [2:0] tmds_data_p ,
    output wire [2:0] tmds_data_n, //HDMI图像差分信号

    //from ddr3
    input [23:0]         pixel_data,     //对应像素点的像素信息
    output               data_req,
    //to ddr3
    output [10:0]        display_xpos,
    output [10:0]        display_ypos
    );
//*****************************************************************
//      Internal Signals
//*****************************************************************
    wire                display_hs;     //行同步信号
    wire                display_vs;     //场同步信号
    wire                display_de;     //数据使能
    wire [23:0]         display_rgb;

//*****************************************************************
//      Main part
//*****************************************************************

    Display_Driver display_driver1(
        //input
        .pixel_clk      (clk_1x),
        .sys_rst_n      (sys_rst_n),
        .pixel_data     (pixel_data),     //对应像素点的像素信息
        //output
        .display_hs     (display_hs),     //行同步信号
        .display_vs     (display_vs),     //场同步信号
        .display_de     (display_de),     //数据使能
        .display_rgb    (display_rgb),
        .display_xpos   (display_xpos),
        .display_ypos   (display_ypos),
        .data_req       (data_req)
    );

    HDMI_CTL hdmi_ctl(
        //input
        .clk_1x         (clk_1x),               //输入系统时钟
        .clk_5x         (clk_5x),               //输入5倍系统时钟
        .sys_rst_n      (sys_rst_n),            //复位信号,低有效
        .rgb_blue       (display_rgb[7:0]),     //蓝色分量
        .rgb_green      (display_rgb[15:8]),    //绿色分量
        .rgb_red        (display_rgb[23:16]),   //红色分量
        .hsync          (display_hs),           //行同步信号
        .vsync          (display_vs),           //场同步信号
        .de             (display_de),           //使能信号
        //output
        .hdmi_clk_p     (tmds_clk_p),
        .hdmi_clk_n     (tmds_clk_n),           //时钟差分信号
        .hdmi_r_p       (tmds_data_p[2]),
        .hdmi_r_n       (tmds_data_n[2]),      //红色分量差分信号
        .hdmi_g_p       (tmds_data_p[1]),
        .hdmi_g_n       (tmds_data_n[1]),      //绿色分量差分信号
        .hdmi_b_p       (tmds_data_p[0]),
        .hdmi_b_n       (tmds_data_n[0]) //蓝色分量差分信号        
    );

endmodule
