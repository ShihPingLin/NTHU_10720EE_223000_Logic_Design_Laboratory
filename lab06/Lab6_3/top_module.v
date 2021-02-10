`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 11:59:53
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
    mode,           //for year -> month.day -> time
    mode_ap,        //24hour <-> 12hour
    mode_clk,
    clk,
    rst
);
output [6:0] segs;
output [3:0] ssd_ctl;
output point;
input mode, mode_ap, clk, rst;
input mode_clk;
wire [3:0] ssd_in;
wire [1:0] ssd_ctl_en;
wire [3:0] digit0, digit1, digit2, digit3;
wire clk_fast, clk_1, clk_out, clk_100, rst_n;
wire [3:0] sec0, sec1;
wire [3:0] min0, min1;
wire [3:0] hr0_24, hr1_24, hr0_12, hr1_12;
wire [3:0] day0, day1;
wire [3:0] month0, month1;
wire [3:0] year0, year1, year2, year3;
wire point_tmp, point_tmp2;
wire mode_mid, mode_one;

assign rst_n = ~rst;
assign point = ~((point_tmp2 == 1'b1) && (ssd_ctl == 4'b1011));
assign clk_out = (mode_clk) ? clk_fast : clk_1;

frequency_divider U0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_fast(clk_fast),    //for demo
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(clk_100), //generated 100Hz clock
    .clk_ctl(ssd_ctl_en) //scan control
);

debounce_circuit U1(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(mode),  //push botton input
    .pb_debounced(mode_mid)    //debounced push botton output
);

one_pulse U2(
    .clk(clk),    //global clock
    .rst_n(rst_n),
    .in_trig(mode_mid),
    .out_pulse(mode_one)
);

counter U3(
    .sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .hr0_24(hr0_24),
    .hr1_24(hr1_24),
    .hr0_12(hr0_12),
    .hr1_12(hr1_12),
    .day0(day0),
    .day1(day1),
    .month0(month0),
    .month1(month1),
    .year0(year0),
    .year1(year1),
    .year2(year2),
    .year3(year3),
    .point_tmp(point_tmp),
    .clk(clk_out),
    .rst_n(rst_n)   //negative edge reset
);

FSM_and_MUX U4(
    .digit0(digit0),
    .digit1(digit1),
    .digit2(digit2),
    .digit3(digit3),
    .point_tmp(point_tmp),
    .point_tmp2(point_tmp2),
    .mode(mode_one),
    .mode_ap(mode_ap),
    .sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .hr0_24(hr0_24),
    .hr1_24(hr1_24),
    .hr0_12(hr0_12),
    .hr1_12(hr1_12),
    .day0(day0),
    .day1(day1),
    .month0(month0),
    .month1(month1),
    .year0(year0),
    .year1(year1),
    .year2(year2),
    .year3(year3),
    .clk(clk),      //same as one pulse
    .rst_n(rst_n)
);

scan_ctl U5(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(digit3),        //1st input
    .in1(digit2),        //2nd input
    .in2(digit1),        //3rd input
    .in3(digit0),        //4th input
    .ssd_ctl_en(ssd_ctl_en)  //divided clock for scan control
);

display U6(
    .D_ssd(segs),    //seven_segment output
    .i(ssd_in)       //input counter value
);

endmodule
