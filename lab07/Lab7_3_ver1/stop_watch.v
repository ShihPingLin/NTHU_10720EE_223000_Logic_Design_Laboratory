`timescale 1ns / 1ps

module stop_watch(
    digit0,
    digit1,
    digit2,
    digit3,
    count_enable,
    rst_state,
    lap,
    clk,
    rst_n
);
output [3:0] digit0, digit1, digit2, digit3;
input count_enable, rst_state, lap;
input clk, rst_n;
wire [3:0] sec0, sec1, min0, min1;
wire clk_1;

clock_generator Us0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(), //generated 100Hz clock
    .clk_ctl() //scan control
);
    
counter Us1(
    .sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .count_enable(count_enable),
    .rst_state(rst_state),
    .clk(clk_1),    //global clock
    .rst_n(rst_n)   //negative edge reset
);

MUX_in_stop_watch Us2(
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

endmodule
