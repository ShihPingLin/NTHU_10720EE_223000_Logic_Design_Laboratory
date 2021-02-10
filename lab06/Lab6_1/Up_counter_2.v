`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 18:26:34
// Design Name: 
// Module Name: Up_counter_2
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

module Up_counter_2(
    value,  //counter output
    value_initial,  //value after reset
    clk,    //global clock
    rst_n,  //active low reset
    increase,   //counter enable control
    limit   //limit for the counter
);
output [4:0] value;
input [4:0] value_initial;
input [4:0] limit;
input clk, rst_n, increase;
reg [4:0] value, value_tmp;

always @*
    if (value == limit && increase)
        value_tmp = 5'd0;
    else if (value != limit && increase)
        value_tmp = value + 5'd1;
    else
        value_tmp = value;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value <= value_initial;
    else
        value <= value_tmp;
 
endmodule