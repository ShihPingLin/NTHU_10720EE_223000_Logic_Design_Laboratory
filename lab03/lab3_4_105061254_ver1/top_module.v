`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 00:16:37
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


module top_module(clk, rst_n, ssd_ctl, D_ssd);
input clk, rst_n;
output [3:0] ssd_ctl;
output [7:0] D_ssd;
wire clk_out;
wire [1:0] clk_ctl;
wire [5:0] q;

freqency_divider U0(
    .clk_out(clk_out),    //divided clock output
    .clk_ctl(clk_ctl),    //divided clock output for scan frequency
    .clk(clk),        //global clock input
    .rst_n(rst_n)       //active low reset
);

shifter U1(
    .q(q),
    .clk(clk_out),
    .rst_n(rst_n)
);

display U2(
    .D_ssd(D_ssd),
    .ssd_ctl(ssd_ctl),
    .clk_ctl(clk_ctl),
    .q(q)
);

endmodule
