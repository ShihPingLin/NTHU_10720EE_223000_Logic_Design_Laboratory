`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 22:54:48
// Design Name: 
// Module Name: Up_counter_year
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

module Up_counter_year(
    year0,              //counter output
    year1,
    value_initial,      //value after reset
    clk,                //global clock
    rst_n,              //active low reset
    increase,           //counter enable control
    limit               //limit for the counter
);
output [3:0] year0, year1;
input [6:0] value_initial;
input [6:0] limit;
input clk, rst_n, increase;
reg [6:0] value, value_tmp;
reg [3:0] year0, year1;

always @*
begin
    year0 = value % 10;
    year1 = value / 10;
end

always @*
    if (value == limit && increase)
        value_tmp = 7'd0;
    else if (value != limit && increase)
        value_tmp = value + 7'd1;
    else
        value_tmp = value;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value <= value_initial;
    else
        value <= value_tmp;
 
endmodule