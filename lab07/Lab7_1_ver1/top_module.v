`timescale 1ns / 1ps

module top_module(
    state,
    segs,    
    point,
    ssd_ctl,
    start_in,
    lap_in,
    clk,
    rst_in   
);
output [1:0] state;
output [6:0] segs;
output point;
output [3:0] ssd_ctl;
input start_in, lap_in;
input clk, rst_in;
wire rst_n;
wire [1:0] clk_ctl;
wire clk_1;
wire start_pulse, lap_pulse, rst;
wire lap, count_enable, rst_state;
wire [3:0] sec0, sec1, min0, min1;
wire [3:0] digit0, digit1, digit2, digit3;
wire [3:0] ssd_in;

assign point = 1'b1;
assign rst_n = ~rst_in;

clock_generator U0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(), //generated 100Hz clock
    .clk_ctl(clk_ctl) //scan control
);

top_botton U1(
    .start_pulse(start_pulse),
    .lap_pulse(lap_pulse),
    .rst(rst),
    .start_in(start_in),
    .lap_in(lap_in),
    .clk(clk),
    .rst_n(rst_n)   
);

fsm U2(
    .state(state),  //for debug
    .count_enable(count_enable),
    .lap(lap),
    .rst_state(rst_state),
    .start_pulse(start_pulse),
    .lap_pulse(lap_pulse),
    .rst(rst),
    .clk(clk),
    .rst_n(rst_n)
);

counter U3(
    .sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .count_enable(count_enable),
    .rst_state(rst_state),
    .clk(clk_1),    //global clock
    .rst_n(rst_n)   //negative edge reset
);

MUX U4(
    .digit0(digit0),
    .digit1(digit1),
    .digit2(digit2),
    .digit3(digit3),
    .rst_state(rst_state),
    .lap(lap),
    .sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .clk(clk),
    .rst_n(rst_n)
);

scan_ctl U5(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(digit3),        //1st input
    .in1(digit2),        //2nd input
    .in2(digit1),        //3rd input
    .in3(digit0),        //4th input
    .ssd_ctl_en(clk_ctl)  //divided clock for scan control
);

display U6(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);

endmodule
