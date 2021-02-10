`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 00:44:32
// Design Name: 
// Module Name: pre_lab3_1_myver
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

module bincnt(q, clk, rst_n);

output [3:0] q;
input clk;
input rst_n;

reg [3:0] q;
reg [3:0] q_tmp;    //q_temp is next state of q

always @*
begin
    q_tmp[3] = ((~q[1]) & q[3]) | ((~q[0]) & q[3]) | ((~q[2]) & q[3]) | (q[0] & q[1] & q[2] & (~q[3]));
    q_tmp[2] = ((~q[1]) & q[2]) | ((~q[0]) & q[2]) | (q[0] & q[1] & (~q[2]));
    q_tmp[1] = q[0] ^ q[1];
    q_tmp[0] = (~q[0]);
end

always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        q <= 4'd0;
    else
        q <= q_tmp;
end
endmodule