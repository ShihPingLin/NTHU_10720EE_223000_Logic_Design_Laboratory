`timescale 1ns / 1ps

module top_botton(
    in1_pulse,
    in2_pulse,
    in2_long_pulse,
    mode_pulse,
    in1,
    in2,
    mode_in,
    clk,
    rst_n
);
output in1_pulse, in2_pulse, in2_long_pulse, mode_pulse;
input in1, in2, mode_in;
input clk, rst_n;
wire clk_100, clk_1;
wire d_in1, d_in2, d_mode_in;

clock_generator Ub0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(clk_100), //generated 100Hz clock
    .clk_ctl() //scan control
);

debounce_circuit Ub1(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(in1),  //push botton input
    .pb_debounced(d_in1)    //debounced push botton output
);

debounce_circuit Ub2(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(in2),  //push botton input
    .pb_debounced(d_in2)    //debounced push botton output
);

debounce_circuit Ub3(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(mode_in),  //push botton input
    .pb_debounced(d_mode_in)    //debounced push botton output
);

one_pulse Ub4(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_in1),
    .out_pulse(in1_pulse)
);

one_pulse Ub5(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_in2),
    .out_pulse(in2_pulse)
);

one_pulse Ub6(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_mode_in),
    .out_pulse(mode_pulse)
);

shift_register Ub7(
    .rst(in2_long_pulse),
    .in(d_in2),
    .clk(clk_1),
    .rst_n(rst_n)
);

endmodule