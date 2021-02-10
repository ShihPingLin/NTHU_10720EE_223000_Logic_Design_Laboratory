`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 11:25:52
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
    carry,
    clk,    //global clock
    rst_n,  //active low reset
    increase,   //counter enable control
    limit   //limit for the counter
);
output [4:0] value;
output carry;
input [4:0] value_initial;
input [4:0] limit;
input clk, rst_n, increase;
reg [4:0] value, value_tmp;
reg carry;

always @*
    if (value == limit && increase)
    begin
        value_tmp = 5'd0;
        carry = 1;
    end
    else if (value != limit && increase)
    begin
        value_tmp = value + 5'd1;
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