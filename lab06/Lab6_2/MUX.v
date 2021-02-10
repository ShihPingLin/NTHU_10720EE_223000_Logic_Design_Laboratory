`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 23:17:57
// Design Name: 
// Module Name: MUX
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


module MUX(
    mode,
    digit0,
    digit1,
    digit2,
    digit3,
    day0,
    day1,
    month0,
    month1,
    year0,
    year1
);
output [3:0] digit0, digit1, digit2, digit3;
input mode;
input [3:0] day0, day1;
input [3:0] month0, month1;
input [3:0] year0, year1;
reg [3:0] digit0, digit1, digit2, digit3;

always @*
    if (~mode)  //month and day 
    begin
        digit0 = month1;
        digit1 = month0;
        digit2 = day1;
        digit3 = day0;
    end
    else        //year
    begin
        digit0 = 4'b1111;
        digit1 = 4'b1111;
        digit2 = year1;
        digit3 = year0;
    end

endmodule
