`timescale 1ns / 1ps

module botton(
    in_do_pulse,
    in_re_pulse,
    in_mi_pulse,
    in_do,
    in_re,
    in_mi,
    clk,
    rst_n
);
output in_do_pulse, in_re_pulse, in_mi_pulse;
input in_do, in_re, in_mi;
input clk, rst_n;
wire clk_100;
wire d_in_do, d_in_re, d_in_mi;

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

one_pulse Ub4(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_in_do),
    .out_pulse(in_do_pulse)
);

one_pulse Ub5(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_in_re),
    .out_pulse(in_re_pulse)
);

one_pulse Ub6(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_in_mi),
    .out_pulse(in_mi_pulse)
);

endmodule
