`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 18:18:34
// Design Name: 
// Module Name: top_module
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


module top_module(
    out,    //LED output
    rst_n,  //global reset
    clk     //global clock
    );
output [3:0] out;
input rst_n;
input clk;
wire clk_out;

binary_up_counter U0(
    .out(out),        //LED output
    .clk(clk_out),    //clock after drequency divider
    .rst_n(rst_n)     //global rst
);

frequency_divider U1(
    .clk(clk),    //global clock
    .rst_n(rst_n),  //global rst
    .clk_out(clk_out) //divider clock output
);

endmodule
