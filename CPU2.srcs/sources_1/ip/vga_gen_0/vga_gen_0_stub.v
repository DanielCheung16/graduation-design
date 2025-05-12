// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri Apr 11 22:20:05 2025
// Host        : DESKTOP-GAA9OIO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top vga_gen_0 -prefix
//               vga_gen_0_ vga_gen_0_stub.v
// Design      : vga_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module vga_gen_0(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[3:0],addra[16:0],dina[31:0],douta[31:0],clkb,enb,web[3:0],addrb[16:0],dinb[31:0],doutb[31:0]" */;
  input clka;
  input ena;
  input [3:0]wea;
  input [16:0]addra;
  input [31:0]dina;
  output [31:0]douta;
  input clkb;
  input enb;
  input [3:0]web;
  input [16:0]addrb;
  input [31:0]dinb;
  output [31:0]doutb;
endmodule
