`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/25 18:24:10
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
    clk,
    pb_in,
    pb_in_mode,
    ssd_ctl,
    segs,
    point,
    LED_control
);
output [3:0]ssd_ctl;
output [6:0]segs;
output point;
output [15:0]LED_control;
input clk;
input pb_in, pb_in_mode;
wire count_enable;
wire rst_n;
wire [3:0] initial_10, initial_100;

from_botton_to_fsm U0(
    .count_enable(count_enable),
    .initial_10(initial_10),
    .initial_100(initial_100),
    .rst_n(rst_n),
    .clk(clk),
    .pb_in(pb_in),
    .pb_in_mode(pb_in_mode)
);

from_bincnt_to_display U1(
    .segs(segs),   //7-segment display
    .ssd_ctl(ssd_ctl),    //scan control
    .LED_control_out(LED_control),
    .clk(clk),    //clock from oscillator
    .rst_n(rst_n),   //active low reset
    .count_enable(count_enable),
    .initial_10(initial_10),
    .initial_100(initial_100),
    .point(point)
);

endmodule
