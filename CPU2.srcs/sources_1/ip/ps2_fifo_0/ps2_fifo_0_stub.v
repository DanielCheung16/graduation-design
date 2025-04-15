// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Apr 13 11:10:45 2025
// Host        : DESKTOP-GAA9OIO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top ps2_fifo_0 -prefix
//               ps2_fifo_0_ ps2_fifo_stub.v
// Design      : ps2_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_3,Vivado 2018.3" *)
module ps2_fifo_0(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, 
  empty)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[8:0],wr_en,rd_en,dout[8:0],full,empty" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [8:0]din;
  input wr_en;
  input rd_en;
  output [8:0]dout;
  output full;
  output empty;
endmodule
