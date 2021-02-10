`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 22:22:54
// Design Name: 
// Module Name: Up_counter_day
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

module Up_counter_day(
    day0,               //counter output
    day1,
    carry,              //borrow indicator    
    value_initial,      //value after reset
    clk,                //global clock
    rst_n,              //active low reset
    increase,           //counter enable control
    limit               //limit for the counter
);
output [3:0] day0, day1;
output carry;
input [4:0] value_initial;
input [4:0] limit;              //will change with month
input clk, rst_n, increase;
reg [3:0] day0, day1;
reg [4:0] value, value_tmp;
reg carry;

always @*
begin
    day0 = value % 10;
    day1 = value / 10;
end

always @*
    if (value == limit && increase)
    begin
        value_tmp = 5'd1;
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