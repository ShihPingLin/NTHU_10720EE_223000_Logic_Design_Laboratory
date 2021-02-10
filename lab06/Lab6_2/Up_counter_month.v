`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 22:29:39
// Design Name: 
// Module Name: Up_counter_month
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

module Up_counter_month(
    limit_for_day,      //the limit for day
    month0,             //counter output
    month1,
    carry,              //borrow indicator    
    value_initial,      //value after reset
    clk,                //global clock
    rst_n,              //active low reset
    increase,           //counter enable control
    limit               //limit for the counter
);
output [4:0] limit_for_day;
output [3:0] month0, month1;
output carry;
input [3:0] value_initial;
input [3:0] limit;
input clk, rst_n, increase;
reg [3:0] month0, month1;
reg [4:0] limit_for_day;
reg [3:0] value, value_tmp;
reg carry;

always @*
begin
    month0 = value % 10;
    month1 = value / 10;
end

always @*
    case(value)
        4'd1:limit_for_day = 5'd31;
        4'd2:limit_for_day = 5'd28;
        4'd3:limit_for_day = 5'd31;
        4'd4:limit_for_day = 5'd30;
        4'd5:limit_for_day = 5'd31;
        4'd6:limit_for_day = 5'd30;
        4'd7:limit_for_day = 5'd31;
        4'd8:limit_for_day = 5'd31;
        4'd9:limit_for_day = 5'd30;
        4'd10:limit_for_day = 5'd31;
        4'd11:limit_for_day = 5'd30;
        4'd12:limit_for_day = 5'd31;
        default:limit_for_day = 5'd0;
    endcase

always @*
    if (value == limit && increase)
    begin
        value_tmp = 4'd1;
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