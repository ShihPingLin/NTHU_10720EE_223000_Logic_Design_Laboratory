`timescale 1ns / 1ps

module top_module(
    //in1_pulse,
    //in2_pulse,
    //in2_long_pulse,
    //mode_pulse,
    //state,
    LED_control,
    segs,
    point,
    ssd_ctl,
    mode_in,
    in1,
    in2,
    clk,
    rst_in
);
output [15:0] LED_control;
output [6:0] segs;
output point;
output [3:0] ssd_ctl;
input in1, in2, mode_in;
input clk, rst_in;
wire rst_n, clk_1;
wire [1:0] clk_ctl;
wire in1_pulse, in2_pulse, in2_long_pulse, mode_pulse;
wire mode;
wire count_enable_2, stop, setting, count_enable, lap, rst_state;
wire [3:0] digit0_stop, digit1_stop, digit2_stop, digit3_stop;
wire [3:0] digit0_timer, digit1_timer, digit2_timer, digit3_timer;
wire [3:0] digit0, digit1, digit2, digit3;
wire [15:0] LED_control;
wire [15:0] LED_control_tmp;
wire [3:0] ssd_in;

assign rst_n = ~rst_in;
assign point = (setting == 1'b1 && ssd_ctl == 4'b1011) ? 1'b0 : 1'b1;

clock_generator U0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(), //generated 100Hz clock
    .clk_ctl(clk_ctl) //scan control
);

top_botton U1(
    .in1_pulse(in1_pulse),
    .in2_pulse(in2_pulse),
    .in2_long_pulse(in2_long_pulse),
    .mode_pulse(mode_pulse),
    .in1(in1),
    .in2(in2),
    .mode_in(mode_in),
    .clk(clk),
    .rst_n(rst_n)
);

fsm U2(
    .mode(mode),
    .count_enable_2(count_enable_2),
    .stop(stop),
    .setting(setting),
    .count_enable(count_enable),
    .lap(lap),
    .rst_state(rst_state),
    .in1_pulse(in1_pulse),
    .in2_pulse(in2_pulse),
    .in2_long_pulse(in2_long_pulse),
    .mode_pulse(mode_pulse),
    .clk(clk),
    .rst_n(rst_n)
);

stop_watch U3(
    .digit0(digit0_stop),
    .digit1(digit1_stop),
    .digit2(digit2_stop),
    .digit3(digit3_stop),
    .count_enable(count_enable),
    .rst_state(rst_state),
    .lap(lap),
    .clk(clk),
    .rst_n(rst_n)
);

timer U4(
    .LED_control(LED_control_tmp),
    .digit0(digit0_timer),
    .digit1(digit1_timer),
    .digit2(digit2_timer),
    .digit3(digit3_timer),
    .stop(stop),
    .count_enable_2(count_enable_2),
    .in1_pulse(in1_pulse),
    .in2_pulse(in2_pulse),
    .setting(setting),
    .clk(clk),
    .rst_n(rst_n)
);

MUX U5(
    .LED_control(LED_control),
    .digit0(digit0),
    .digit1(digit1),
    .digit2(digit2),
    .digit3(digit3),
    .mode(mode),
    .digit0_timer(digit0_timer),
    .digit1_timer(digit1_timer),
    .digit2_timer(digit2_timer),
    .digit3_timer(digit3_timer),
    .digit0_stop(digit0_stop),
    .digit1_stop(digit1_stop),
    .digit2_stop(digit2_stop),
    .digit3_stop(digit3_stop),
    .LED_control_tmp(LED_control_tmp)  
);

scan_ctl U6(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(digit3),        //1st input
    .in1(digit2),        //2nd input
    .in2(digit1),        //3rd input
    .in3(digit0),        //4th input
    .ssd_ctl_en(clk_ctl)  //divided clock for scan control
);

display U7(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);

endmodule
