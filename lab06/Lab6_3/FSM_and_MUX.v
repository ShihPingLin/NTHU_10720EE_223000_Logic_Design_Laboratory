`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 12:08:57
// Design Name: 
// Module Name: FSM_and_MUX
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

module FSM_and_MUX(
    digit0,
    digit1,
    digit2,
    digit3,
    mode,
    mode_ap,
    sec0,
    sec1,
    min0,
    min1,
    hr0_24,
    hr1_24,
    hr0_12,
    hr1_12,
    day0,
    day1,
    month0,
    month1,
    year0,
    year1,
    year2,
    year3,
    point_tmp,
    point_tmp2,
    clk,
    rst_n
);
output [3:0] digit0, digit1, digit2, digit3;
output point_tmp2;
input mode, mode_ap;
input [3:0] sec0, sec1;
input [3:0] min0, min1;
input [3:0] hr0_24, hr1_24, hr0_12, hr1_12;
input [3:0] day0, day1;
input [3:0] month0, month1;
input [3:0] year0, year1, year2, year3;
input point_tmp;
input clk, rst_n;
reg point_tmp2;
reg [3:0] digit0, digit1, digit2, digit3;
reg [1:0] state;
reg [1:0] next_state;

always @*
    if (state == 2'd0)  //year mode
    begin
        digit3 = year3;
        digit2 = year2;
        digit1 = year1;
        digit0 = year0;
        point_tmp2 = 1'b0;
    end
    else if (state == 2'd1) //month/day mode
    begin
        digit3 = month1;
        digit2 = month0;
        digit1 = day1;
        digit0 = day0;
        point_tmp2 = 1'b0;
    end
    else if (state == 2'd2) //hour/minute
    begin
        if (~mode_ap)   //24 hour
        begin
            digit3 = hr1_24;
            digit2 = hr0_24;
            digit1 = min1;
            digit0 = min0;
            point_tmp2 = 1'b0;
        end
        else
        begin
            digit3 = hr1_12;
            digit2 = hr0_12;
            digit1 = min1;
            digit0 = min0;
            point_tmp2 = point_tmp;
        end
    end
    else    //second
    begin
        digit3 = 4'b1111;
        digit2 = 4'b1111;
        digit1 = sec1;
        digit0 = sec0;
        point_tmp2 = 1'b0;
    end

//FSM state decision
always @*
    case (state)
        2'd0:       //year
        if (mode)
            next_state = 2'd1;
        else
            next_state = 2'd0;
        
        2'd1:       //month/day
        if (mode)
            next_state = 2'd2;
        else
            next_state = 2'd1;
        
        2'd2:       //minute <-> hour
        if (mode)
            next_state = 2'd3;
        else
            next_state = 2'd2;
        
        2'd3:       //second
        if (mode)
            next_state = 2'd0;
        else
            next_state = 2'd3;
        
        default:    //only for format of case
            next_state = 1'b0;       
    endcase
    
//FSM state transition
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 2'd0;
    else
        state <= next_state;

endmodule
