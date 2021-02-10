`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 19:08:24
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
    mode2,
    point_tmp,
    point_tmp2,
    digit3,
    digit2,
    digit1,
    digit0,
    sec0,
    sec1,
    min0,
    min1,
    hr0_24,
    hr1_24,
    hr0_12,
    hr1_12
);
output point_tmp2;
output [3:0] digit3, digit2, digit1, digit0;
input [3:0] hr0_24, hr1_24, hr0_12, hr1_12;
input [3:0] sec0, sec1, min0, min1;
input mode, mode2, point_tmp;
reg point_tmp2;
reg [3:0] digit3, digit2, digit1, digit0;

always @*
    if ((!mode) && (!mode2))  //24hour and minute/hour
    begin 
        digit0 = hr1_24;
        digit1 = hr0_24;
        digit2 = min1;
        digit3 = min0;
        point_tmp2 = 1'b0;
    end
    else if ((mode) && (!mode2))    //12hour and minute/hour
    begin
        digit0 = hr1_12;
        digit1 = hr0_12;
        digit2 = min1;
        digit3 = min0;
        point_tmp2 = point_tmp;
    end
    else    //only second
    begin
        digit0 = 4'b1111;
        digit1 = 4'b1111;
        digit2 = sec1;
        digit3 = sec0;
        point_tmp2 = 1'b0;
    end

endmodule
