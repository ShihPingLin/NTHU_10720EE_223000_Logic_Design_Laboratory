`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 18:05:11
// Design Name: 
// Module Name: binary_up_counter
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


module binary_up_counter(
    out,        //LED output
    clk,        //clock after drequency divider
    rst_n       //global rst
);
output [3:0] out;
input clk;
input rst_n;
reg [3:0] out;
reg [3:0] out_tmp;

always @*
    out_tmp = out + 1'b1;

always @(posedge clk, negedge rst_n)
    if (~rst_n)
        out <= 4'b0000;
    else
        out <= out_tmp;
 
endmodule
