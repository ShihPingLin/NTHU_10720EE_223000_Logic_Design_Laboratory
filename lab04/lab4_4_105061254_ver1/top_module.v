`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/15 13:14:34
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
    clk,    //clock from oscillator
    rst_n   //active low reset
);
output [7:0] segs;
output [3:0] ssd_ctl;
input clk;
input rst_n;
wire clk_out;
wire [1:0] ssd_ctl_en;
wire [3:0] digit0, digit1;
wire [3:0] ssd_in;

//Frequency_divider
freqency_divider U0(
    .clk_out(clk_out),    //divided clock output
    .clk_ctl(ssd_ctl_en),    //divided clock output for scan frequency
    .clk(clk),        //global clock input
    .rst_n(rst_n)       //active low reset
);

//two_digit_binary_down_counter
two_digit_bincnt U1(
    .digit0(digit0), //digit in one
    .digit1(digit1), //digit in ten
    .clk(clk_out),    //global clock
    .rst_n(rst_n)   //negative edge reset
);

//Scan_control
scan_ctl U2(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(4'b1111),        //1st input
    .in1(4'b1111),        //2nd input
    .in2(digit1),        //3rd input
    .in3(digit0),        //4th input
    .ssd_ctl_en(ssd_ctl_en)  //divided clock for scan control
);

//display
display U3(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);
endmodule
