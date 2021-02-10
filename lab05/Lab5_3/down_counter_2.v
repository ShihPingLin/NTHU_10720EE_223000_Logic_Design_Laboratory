`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/29 00:25:56
// Design Name: 
// Module Name: down_counter_2
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

module down_counter_2(
    value_2,  //counter output
    value_initial,  //value after reset
    borrow_2, //borrow indicator
    clk,    //global clock
    rst_n,  //active low reset
    decrease,   //counter enable control
    limit   //limit for the counter
);
output [3:0] value_2;
output borrow_2;
input [3:0] value_initial;
input [3:0] limit;
input clk, rst_n, decrease;
reg [3:0] value_2, value_tmp_2;
reg borrow_2;

always @*
    if (value_2 == 4'd0 && decrease)
    begin
        value_tmp_2 = limit;
        borrow_2 = 1;
    end
    else if (value_2 != 4'd0 && decrease)
    begin
        value_tmp_2 = value_2 - 4'd1;
        borrow_2 = 0;
    end
    else
    begin
        value_tmp_2 = value_2;
        borrow_2 = 0;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value_2 <= value_initial;
    else
        value_2 <= value_tmp_2;
 
endmodule