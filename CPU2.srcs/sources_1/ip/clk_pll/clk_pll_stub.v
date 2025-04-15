// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Apr 14 08:09:36 2025
// Host        : DESKTOP-GAA9OIO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub e:/FPGA/Senior1/CPU2/CPU2.srcs/sources_1/ip/clk_pll/clk_pll_stub.v
// Design      : clk_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_pll(clk_parallel, clk_serial, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_parallel,clk_serial,reset,locked,clk_in1" */;
  output clk_parallel;
  output clk_serial;
  input reset;
  output locked;
  input clk_in1;
endmodule
