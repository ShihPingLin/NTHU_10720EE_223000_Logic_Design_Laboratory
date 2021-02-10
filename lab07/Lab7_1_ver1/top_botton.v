`timescale 1ns / 1ps

module top_botton(
    start_pulse,
    lap_pulse,
    rst,
    start_in,
    lap_in,
    clk,
    rst_n   
);
output start_pulse, lap_pulse, rst;
input start_in, lap_in;
input clk, rst_n;
wire clk_1, clk_100;
wire d_start, d_lap;

clock_generator Ub0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(clk_100), //generated 100Hz clock
    .clk_ctl() //scan control
);

//debounce_circuit for start_in
debounce_circuit Ub1(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(start_in),  //push botton input
    .pb_debounced(d_start)    //debounced push botton output
);

//debounce_circuit for lap_in
debounce_circuit Ub2(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(lap_in),  //push botton input
    .pb_debounced(d_lap)    //debounced push botton output
);

//one_pulse for d_start
one_pulse Ub3(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_start),
    .out_pulse(start_pulse)
);

//one_pulse for d_lap
one_pulse Ub4(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_lap),
    .out_pulse(lap_pulse)
);

//shift_register to generate rst
shift_register Ub5(
    .rst(rst),
    .in(d_lap),
    .clk(clk_1),
    .rst_n(rst_n)
);

endmodule
