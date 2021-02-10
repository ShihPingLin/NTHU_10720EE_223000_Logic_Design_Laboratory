`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 00:00:56
// Design Name: 
// Module Name: shifter
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

module shifter(
    q,
    clk,
    rst_n
);

output [5:0] q;
input clk;
input rst_n;
reg [5:0] q;
reg [5:0] q_tmp;

always @*
begin
    q_tmp[0] <= q[0];
    q_tmp[1] <= q[1];
    q_tmp[2] <= q[2];
    q_tmp[3] <= q[3];
    q_tmp[4] <= q[4];
    q_tmp[5] <= q[5];  
end

always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        q <= 6'b000001;
    else begin
        q[1] <= q_tmp[0];
        q[2] <= q_tmp[1];
        q[3] <= q_tmp[2];
        q[4] <= q_tmp[3];
        q[5] <= q_tmp[4];
        q[0] <= q_tmp[5];
    end
end
endmodule
