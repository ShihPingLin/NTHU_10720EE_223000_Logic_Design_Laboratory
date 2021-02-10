`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 23:13:08
// Design Name: 
// Module Name: top_module
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


module top_module(
    segs,
    ssd_ctl,
    point,
    mode,
    clk,
    rst
);
output [6:0] segs;
output [3:0] ssd_ctl;
output point;
input clk, rst, mode;
wire rst_n;
wire clk_out;
wire [3:0] ssd_in;
wire [1:0] ssd_ctl_en;
wire [3:0] digit0, digit1, digit2, digit3;
wire [3:0] day0, day1;
wire [3:0] month0, month1;
wire [3:0] year0, year1;

assign rst_n = ~rst;
assign point = 1'b1;

freqency_divider U0(
    .clk_out(clk_out),       //divided clock output
    .clk_ctl(ssd_ctl_en),    //divided clock output for scan frequency
    .clk(clk),               //global clock input
    .rst_n(rst_n)            //active low reset
);

counter_dmy U1(
    .day0(day0),
    .day1(day1),
    .month0(month0),
    .month1(month1),
    .year0(year0),
    .year1(year1),
    .clk(clk_out),
    .rst_n(rst_n)
);

MUX U2(
    .mode(mode),
    .digit0(digit0),
    .digit1(digit1),
    .digit2(digit2),
    .digit3(digit3),
    .day0(day0),
    .day1(day1),
    .month0(month0),
    .month1(month1),
    .year0(year0),
    .year1(year1)
);

scan_ctl U3(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),      //output to ssd display
    .in0(digit0),         //1st input
    .in1(digit1),         //2nd input
    .in2(digit2),         //3rd input
    .in3(digit3),         //4th input
    .ssd_ctl_en(ssd_ctl_en)  //divided clock for scan control
);

display U4(
    .D_ssd(segs),    //seven_segment output
    .i(ssd_in)       //input counter value
);

endmodule
