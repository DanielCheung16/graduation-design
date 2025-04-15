// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Apr 14 08:16:43 2025
// Host        : DESKTOP-GAA9OIO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub e:/FPGA/Senior1/CPU2/CPU2.srcs/sources_1/ip/clk_pll2/clk_pll2_stub.v
// Design      : clk_pll2
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_pll2(clk_200m, clk_400m, clk_50m, reset, clk_in1_p, 
  clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="clk_200m,clk_400m,clk_50m,reset,clk_in1_p,clk_in1_n" */;
  output clk_200m;
  output clk_400m;
  output clk_50m;
  input reset;
  input clk_in1_p;
  input clk_in1_n;
endmodule
