`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/15 12:59:23
// Design Name: 
// Module Name: down_counter
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

module down_counter(
    value,  //counter output
    value_initial,  //value after reset
    borrow, //borrow indicator
    clk,    //global clock
    rst_n,  //active low reset
    decrease,   //counter enable control
    limit   //limit for the counter
);
output [3:0] value;
output borrow;
input [3:0] value_initial;
input [3:0] limit;
input clk, rst_n, decrease;
reg [3:0] value, value_tmp;
reg borrow;

always @*
    if (value == 4'd0 && decrease)
    begin
        value_tmp = limit;
        borrow = 1;
    end
    else if (value != 4'd0 && decrease)
    begin
        value_tmp = value - 4'd1;
        borrow = 0;
    end
    else
    begin
        value_tmp = value;
        borrow = 0;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value <= value_initial;
    else
        value <= value_tmp;
 
endmodule