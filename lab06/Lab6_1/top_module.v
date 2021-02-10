`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 18:38:59
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
    segs,   //7-segment display
    ssd_ctl,    //scan control
    point,
    mode,
    mode2,
    clk,    //clock from oscillator
    rst   //active low reset
);
output [6:0] segs;
output [3:0] ssd_ctl;
output point;
input mode, mode2, clk, rst;
wire rst_n, clk_out, point_tmp, point_tmp2;
wire [1:0] ssd_ctl_en;
wire [3:0] digit0, digit1, digit2, digit3;
wire [3:0] hr0_24, hr1_24, hr0_12, hr1_12;
wire [3:0] sec0, sec1, min0, min1;
wire [3:0] ssd_in;

assign rst_n = ~rst;
assign point = ~((point_tmp2 == 1'b1) && (ssd_ctl == 4'b1011));

//Frequency_divider
freqency_divider U0(
    .clk_out(clk_out),    //divided clock output
    .clk_ctl(ssd_ctl_en),    //divided clock output for scan frequency
    .clk(clk),        //global clock input
    .rst_n(rst_n)       //active low reset
);

//counter
counter U1(
    .sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .hr0_24(hr0_24),
    .hr1_24(hr1_24),
    .hr0_12(hr0_12),
    .hr1_12(hr1_12),
    .point_tmp(point_tmp),
    .clk(clk_out),    //global clock
    .rst_n(rst_n)   //negative edge reset
);

//Multiplexer
MUX U2(
    .mode(mode),    //for 24 <-> 12 hour conversion
    .mode2(mode2),  //for sec <-> minute/hour conversion
    .point_tmp(point_tmp),
    .point_tmp2(point_tmp2),
    .digit3(digit3),
    .digit2(digit2),
    .digit1(digit1),
    .digit0(digit0),
    .sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .hr0_24(hr0_24),
    .hr1_24(hr1_24),
    .hr0_12(hr0_12),
    .hr1_12(hr1_12)
);

//Scan_control
scan_ctl U3(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(digit0),        //1st input
    .in1(digit1),        //2nd input
    .in2(digit2),        //3rd input
    .in3(digit3),        //4th input
    .ssd_ctl_en(ssd_ctl_en)  //divided clock for scan control
);

//display
display U4(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);
endmodule