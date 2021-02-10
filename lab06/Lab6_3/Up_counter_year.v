`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 11:37:23
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
    year2,
    year3,
    limit_for_Feb,
    value_initial,      //value after reset
    clk,                //global clock
    rst_n,              //active low reset
    increase,           //counter enable control
    limit               //limit for the counter
);
output [3:0] year0, year1, year2, year3;
output [4:0] limit_for_Feb;
input [11:0] value_initial;
input [11:0] limit;
input clk, rst_n, increase;
reg [11:0] value, value_tmp, value_cal, value_cal2;
reg [3:0] year0, year1, year2, year3;

assign limit_for_Feb = ((value % 4) == 0) ? 5'd29 : 5'd28;

always @*
begin
    year3 = value / 1000;
    value_cal = value % 1000;
    year2 = value_cal / 100;
    value_cal2 = value_cal % 100;
    year1 = value_cal2 / 10;
    year0 = value_cal2 % 10;
end

always @*
    if (value == limit && increase)
        value_tmp = 12'd0;
    else if (value != limit && increase)
        value_tmp = value + 12'd1;
    else
        value_tmp = value;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value <= value_initial;
    else
        value <= value_tmp;
 
endmodule