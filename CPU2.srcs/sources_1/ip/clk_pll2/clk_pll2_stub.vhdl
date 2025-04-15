-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Mon Apr 14 08:16:43 2025
-- Host        : DESKTOP-GAA9OIO running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub e:/FPGA/Senior1/CPU2/CPU2.srcs/sources_1/ip/clk_pll2/clk_pll2_stub.vhdl
-- Design      : clk_pll2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_pll2 is
  Port ( 
    clk_200m : out STD_LOGIC;
    clk_400m : out STD_LOGIC;
    clk_50m : out STD_LOGIC;
    reset : in STD_LOGIC;
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC
  );

end clk_pll2;

architecture stub of clk_pll2 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_200m,clk_400m,clk_50m,reset,clk_in1_p,clk_in1_n";
begin
end;
