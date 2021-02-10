`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/19 12:41:13
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
    ssd_ctl,
    segs,
    LED_control,
    clk,
    pb_in,
    rst_in
);
output [3:0] ssd_ctl;
output [7:0] segs;
output [15:0] LED_control;
input clk;
input pb_in;
input rst_in;
wire count_enable;
wire rst_n;

from_botton_to_fsm U0(
    .clk(clk),    //clock from crystal
    .rst_in(rst_in), //change rst_n to rst_in
    .pb_in(pb_in),  //push button input
    .count_enable(count_enable),
    .rst_n(rst_n)
//    led_1pulse  //LED display output
);

from_bincnt_to_display U1(
    .segs(segs),   //7-segment display
    .ssd_ctl(ssd_ctl),    //scan control
    .clk(clk),    //clock from oscillator
    .rst_n(rst_n),   //active low reset
    .count_enable(count_enable),
    .LED_control(LED_control)
);

endmodule
