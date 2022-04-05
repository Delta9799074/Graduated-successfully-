`timescale 1ns/1ps
module fpga_test_top(
    input  logic clk,    
    input  logic rst,
    output logic txd
);

logic cpu_clk,clock_pll;
clk_pll pll0
   (
    .clk_out1(clock_pll),     //8m
    .clk_in1(clk));  

clk_div cpu_gclk(   
    .clk(clk),
    .clk_out(cpu_clk)          //900
);


sensor_top sensor0(
    .clk_origin(clk),                  //must input 100M clk
    .cpu_clk(cpu_clk),          //input cpu_clk
    .rst(rst),
    .txd(txd)
);
endmodule