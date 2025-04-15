`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/19 19:20:43
// Design Name: 
// Module Name: Display_Driver
// Project Name: 
// Target Devices: Genesys 2 
// Tool Versions: 
// Description: 1.满足HDMI的接口协议。 2.生成行场同步信号
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Display_Driver(
    input               pixel_clk,
    input               sys_rst_n,
    input [23:0]        pixel_data,     //对应像素点的像素信息

    output              display_hs,     //行同步信号
    output              display_vs,     //场同步信号
    output reg          display_de,     //数据使能
    output [23:0]       display_rgb,
    output reg [10:0]   display_xpos,
    output reg [10:0]   display_ypos,

    output reg      data_req
    );
//*****************************************************************
//      参数定义
//*****************************************************************
    //1280*720
    //单位为pixel
    parameter H_SYNC = 11'd40;
    parameter H_BACK = 11'd220;
    parameter H_ACTIVE = 11'd1280;
    parameter H_FRONT = 11'd110;
    parameter H_TOTAL = 11'd1650;
    //单位为行
    parameter V_SYNC = 11'd5;
    parameter V_BACK = 11'd20;
    parameter V_ACTIVE = 11'd720;
    parameter V_FRONT = 11'd5;
    parameter V_TOTAL = 11'd750;

//*****************************************************************
//      Main part
//*****************************************************************
    //行计数器计pixel时间
    reg [10:0] cnt_1;
    
    always @(posedge pixel_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            cnt_1 <= 11'b0;
        end else begin
            if (cnt_1 < H_TOTAL - 1'b1) begin
                cnt_1 <= cnt_1 + 1;
            end else begin
                cnt_1 <= 11'b0;
            end
        end
    end

    //场计数器计行为单位
    reg [10:0] cnt_2;
    
    always @(posedge pixel_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            cnt_2 <= 11'b0;
        end else if(cnt_1 == H_TOTAL - 1'b1) begin
            if (cnt_2 < V_TOTAL - 1'b1) begin
                cnt_2 <= cnt_2 + 1;
            end else begin
                cnt_2 <= 11'b0;
            end
        end else begin
            cnt_2 <= cnt_2;
        end
    end

    //生成data_req信号，判定区域为有效显示区域
    always @(posedge pixel_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            data_req <= 1'b0;
        end else begin
            if (((cnt_1 >= H_SYNC+H_BACK-11'd2) && (cnt_1 < H_SYNC+H_BACK+H_ACTIVE-11'd2))
                &&((cnt_2 >= V_SYNC+V_BACK) && (cnt_2 < V_SYNC+V_BACK+V_ACTIVE))) begin
                data_req <= 1'b1;
            end else begin
                data_req <= 1'b0;
            end
        end
    end

    always @(posedge pixel_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            display_de <= 1'b0;
        end else begin
            display_de <= data_req;
        end
    end

    
    assign display_rgb = display_de ? pixel_data : 24'b0;   //输出的RGB888像素
    assign display_hs = (cnt_1 >= H_SYNC) ? 1'b1 : 1'b0;     //行同步信号
    assign display_vs = (cnt_2 >= V_SYNC) ? 1'b1 : 1'b0;     //场同步信号

    //像素点X坐标
    always @(posedge pixel_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            display_xpos <= 11'b0;
        end else begin
            if (data_req) begin
                display_xpos <= cnt_1 + 2'd2 - H_SYNC - H_BACK;
            end else begin
                display_xpos <= 11'b0;
            end
        end
    end

    //像素点Y坐标
    always @(posedge pixel_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            display_ypos <= 11'b0;
        end else if((cnt_2 >= V_SYNC+V_BACK) && (cnt_2 < V_SYNC+V_BACK+V_ACTIVE))begin
            display_ypos <= cnt_2 + 1'b1 - V_SYNC - V_BACK;
        end else begin
            display_ypos <= 11'b0;
        end
    end

endmodule
