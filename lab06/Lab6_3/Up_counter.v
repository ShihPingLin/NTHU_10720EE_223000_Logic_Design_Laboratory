`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 11:24:50
// Design Name: 
// Module Name: Up_counter
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

module Up_counter(
    value,  //counter output
    value_initial,  //value after reset
    carry, //borrow indicator
    clk,    //global clock
    rst_n,  //active low reset
    increase,   //counter enable control
    limit   //limit for the counter
);
output [3:0] value;
output carry;
input [3:0] value_initial;
input [3:0] limit;
input clk, rst_n, increase;
reg [3:0] value, value_tmp;
reg carry;

always @*
    if (value == limit && increase)
    begin
        value_tmp = 4'd0;
        carry = 1;
    end
    else if (value != limit && increase)
    begin
        value_tmp = value + 4'd1;
        carry = 0;
    end
    else
    begin
        value_tmp = value;
        carry = 0;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value <= value_initial;
    else
        value <= value_tmp;
 
endmodule