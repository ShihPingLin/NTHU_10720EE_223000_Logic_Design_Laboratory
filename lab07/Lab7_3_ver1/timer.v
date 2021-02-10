`timescale 1ns / 1ps

module timer(
    LED_control,
    digit0,
    digit1,
    digit2,
    digit3,
    stop,
    count_enable_2,
    in1_pulse,
    in2_pulse,
    setting,
    clk,
    rst_n
);
output [15:0] LED_control;
output [3:0] digit0, digit1, digit2, digit3;
input count_enable_2, stop;
input in1_pulse, in2_pulse, setting;
input clk, rst_n;
wire [3:0] min_set_0, min_set_1, hour_set_0, hour_set_1;
wire [3:0] min0_tmp, min1_tmp, hour0_tmp, hour1_tmp;
wire [5:0] min_ini, hour_ini;
wire clk_1, clk_1_tmp, clk_fast;

assign digit3 = (setting == 1'b1 || stop == 1'b1) ? hour_set_1 : hour1_tmp;
assign digit2 = (setting == 1'b1 || stop == 1'b1) ? hour_set_0 : hour0_tmp;
assign digit1 = (setting == 1'b1 || stop == 1'b1) ? min_set_1 : min1_tmp;
assign digit0 = (setting == 1'b1 || stop == 1'b1) ? min_set_0 : min0_tmp;

clock_generator Ut0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(), //generated 100Hz clock
    .clk_ctl() //scan control
);

set Ut1(
    .setting(setting),
    .min_set_0(min_set_0),
    .min_set_1(min_set_1),
    .hour_set_0(hour_set_0),
    .hour_set_1(hour_set_1),
    .min_ini(min_ini),
    .hour_ini(hour_ini),
    .min_set(in1_pulse),
    .hour_set(in2_pulse),
    .clk(clk),
    .rst_n(rst_n)
);

counter2 Ut2(
    .min0(min0_tmp),
    .min1(min1_tmp),
    .hour0(hour0_tmp),
    .hour1(hour1_tmp),
    .min_ini(min_ini),
    .hour_ini(hour_ini),
    .LED_control(LED_control),
    .clk(clk_1),    //global clock
    .rst_n(rst_n),   //negative edge reset
    .en(count_enable_2),
    .rst_state(stop),
    .setting(setting)
);

endmodule
