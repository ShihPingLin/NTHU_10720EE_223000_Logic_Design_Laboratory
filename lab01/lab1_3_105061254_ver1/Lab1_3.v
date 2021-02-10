`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 14:26:19
// Design Name: 
// Module Name: Lab1_3
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


module decoder(in, en, d);
output [7:0] d;
input [2:0] in;
input en;

assign d[0] = (~in[0]) & (~in[1]) & (~in[2]) & en;
assign d[1] = in[0] & (~in[1]) & (~in[2]) & en;
assign d[2] = (~in[0]) & in[1] & (~in[2]) & en;
assign d[3] = in[0] & in[1] & (~in[2]) & en;
assign d[4] = (~in[0]) & (~in[1]) & in[2] & en;
assign d[5] = in[0] & (~in[1]) & in[2] & en;
assign d[6] = (~in[0]) & in[1] & in[2] & en;
assign d[7] = in[0] & in[1] & in[2] & en;

endmodule
