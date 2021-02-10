`timescale 1ns / 1ps

module botton(
    in_up_pulse,
    in_down_pulse,
    in_up,
    in_down,
    clk,
    rst_n
);
output in_up_pulse, in_down_pulse;
input in_up, in_down;
input clk, rst_n;
wire clk_100;
wire d_in_up, d_in_down;

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
    .pb_in(in_up),  //push botton input
    .pb_debounced(d_in_up)    //debounced push botton output
);

debounce_circuit Ub2(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(in_down),  //push botton input
    .pb_debounced(d_in_down)    //debounced push botton output
);

one_pulse Ub3(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_in_up),
    .out_pulse(in_up_pulse)
);

one_pulse Ub4(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_in_down),
    .out_pulse(in_down_pulse)
);

endmodule
