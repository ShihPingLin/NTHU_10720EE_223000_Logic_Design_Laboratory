`timescale 1ns / 1ps

module botton(
    d_in_do,
    d_in_re,
    d_in_mi,
    in_do,
    in_re,
    in_mi,
    clk,
    rst_n
);
output d_in_do, d_in_re, d_in_mi;
input in_do, in_re, in_mi;
input clk, rst_n;
wire clk_100;

clock_generator Ub0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(),  //generated 1Hz clock
    .clk_100(clk_100), //generated 100Hz clock
    .clk_ctl() //scan control
);

debounce_circuit Ub1(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(in_do),  //push botton input
    .pb_debounced(d_in_do)    //debounced push botton output
);

debounce_circuit Ub2(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(in_re),  //push botton input
    .pb_debounced(d_in_re)    //debounced push botton output
);

debounce_circuit Ub3(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(in_mi),  //push botton input
    .pb_debounced(d_in_mi)    //debounced push botton output
);

endmodule
