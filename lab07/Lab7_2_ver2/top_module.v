`timescale 1ns / 1ps

module top_module(
    LED_control,
    segs,
    point,
    ssd_ctl,
    setting,
    min_in,
    hour_in,
    start_in,
    pause_in,
    clk,
    rst_in
);
//output [1:0] state; //for debug
//output count_enable, stop;  //for debug
//output [5:0] min_ini, hour_ini; //for debug
output [15:0] LED_control;
output [6:0] segs;
output point;
output [3:0] ssd_ctl;
input setting;
input start_in, pause_in, min_in, hour_in;
input clk, rst_in;
wire rst_n, clk_1, clk_100;
wire [1:0] clk_ctl;
wire start_pulse, pause_pulse, min_pulse, hour_pulse;
wire [1:0] state;
wire count_enable, stop;
wire [5:0] min_ini, hour_ini;
wire [3:0] min0_ini, min1_ini, hour0_ini, hour1_ini;
wire [3:0] min_set_0, min_set_1, hour_set_0, hour_set_1;
wire [3:0] min0_tmp, min1_tmp, hour0_tmp, hour1_tmp;
wire [3:0] min0, min1, hour0, hour1;
wire [3:0] ssd_in;

assign point = 1'b1;
assign rst_n = ~rst_in;

clock_generator U0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(clk_100), //generated 100Hz clock
    .clk_ctl(clk_ctl) //scan control
);

top_botton U1(
    .start_pulse(start_pulse),
    .pause_pulse(pause_pulse),
    .min_pulse(min_pulse),
    .hour_pulse(hour_pulse),
    .start_in(start_in),
    .pause_in(pause_in),
    .min_in(min_in),
    .hour_in(hour_in),
    .clk(clk),
    .rst_n(rst_n)   
);

fsm U2(
    .state(state),  //for debug
    .count_enable(count_enable),
    .stop(stop),
    .start_pulse(start_pulse),
    .pause_pulse(pause_pulse),
    .setting(setting),
    .clk(clk),
    .rst_n(rst_n)
);

set U3(
    .setting(setting),
    .min_set_0(min_set_0),
    .min_set_1(min_set_1),
    .hour_set_0(hour_set_0),
    .hour_set_1(hour_set_1),
    .min_ini(min_ini),
    .hour_ini(hour_ini),
    .min_set(min_pulse),
    .hour_set(hour_pulse),
    .clk(clk),
    .rst_n(rst_n)
);

counter U4(
    .min0(min0_tmp),
    .min1(min1_tmp),
    .hour0(hour0_tmp),
    .hour1(hour1_tmp),
    .min_ini(min_ini),
    .hour_ini(hour_ini),
    .LED_control(LED_control),
    .clk(clk_1),    //global clock
    .rst_n(rst_n),   //negative edge reset
    .en(count_enable),
    .rst_state(stop),
    .setting(setting)
);

assign hour1 = (setting == 1'b1 || stop == 1'b1) ?  hour_set_1 : hour1_tmp;
assign hour0 = (setting == 1'b1 || stop == 1'b1) ? hour_set_0 : hour0_tmp;
assign min1 = (setting == 1'b1 || stop == 1'b1) ? min_set_1 : min1_tmp;
assign min0 = (setting == 1'b1 || stop == 1'b1) ? min_set_0 : min0_tmp;

scan_ctl U5(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(hour1),        //1st input
    .in1(hour0),        //2nd input
    .in2(min1),        //3rd input
    .in3(min0),        //4th input
    .ssd_ctl_en(clk_ctl)  //divided clock for scan control
);

display U6(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);

endmodule
