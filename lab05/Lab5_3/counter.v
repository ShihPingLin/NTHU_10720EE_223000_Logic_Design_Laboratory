`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/25 17:50:47
// Design Name: 
// Module Name: counter
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


module counter(
    clk,
    in,
    pb,
    rst,
    rst_n
);
output pb, rst;
input in, clk, rst_n;
reg [1:0]out;
reg [1:0]tmp_cnt;
reg tmp_rst;
reg tmp_pb;
reg tmp_enable;
reg pb, rst;

always@*
    if (in)
        tmp_cnt = out + 1'b1;
    else
        tmp_cnt = 0;

always@*
    if (tmp_cnt == 3) begin
        pb = 0;
        tmp_rst = 1;
    end
    else if (tmp_cnt < 3 && tmp_cnt != 0) begin
        pb = 1;
        tmp_rst = 0;
    end
    else begin
        pb = 0;
        tmp_rst = 0;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n) begin
        out <= 0;
        rst <= 0;
     end
     else begin
        out <= tmp_cnt;
        rst <= tmp_rst;
     end

endmodule
