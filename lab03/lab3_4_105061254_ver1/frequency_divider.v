`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/10 23:51:28
// Design Name: 
// Module Name: frequency_divider
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

`define FREQ_DIV_BIT 27

module freqency_divider(
    clk_out,    //divided clock output
    clk_ctl,    //divided clock output for scan frequency
    clk,        //global clock input
    rst_n       //active low reset
);

output clk_out;
output [1:0]clk_ctl;
input clk;
input rst_n;

reg clk_out;    //clk output(in always block)
reg [1:0] clk_ctl;
reg [14:0] cnt_l;
reg [8:0] cnt_h;
reg [`FREQ_DIV_BIT - 1:0] cnt_tmp;   //input to dff(in always block)

//combinational logic
always @*
    cnt_tmp = {clk_out, cnt_h, clk_ctl, cnt_l}+ 1'b1;

//sequential logic
always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        {clk_out, cnt_h, clk_ctl, cnt_l} <= `FREQ_DIV_BIT'd0;
    else
        {clk_out, cnt_h, clk_ctl, cnt_l} <= cnt_tmp;
end

endmodule