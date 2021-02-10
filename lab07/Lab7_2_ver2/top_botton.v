`timescale 1ns / 1ps

module top_botton(
    start_pulse,
    pause_pulse,
    min_pulse,
    hour_pulse,
    start_in,
    pause_in,
    min_in,
    hour_in,
    clk,
    rst_n   
);
output start_pulse, pause_pulse, min_pulse, hour_pulse;
input start_in, pause_in, min_in, hour_in;
input clk, rst_n;
wire clk_100, clk_1;
wire d_start, d_pause, d_min, d_hour;

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
    .pb_in(pause_in),  //push botton input
    .pb_debounced(d_pause)    //debounced push botton output
);

//debounce_circuit for lap_in
debounce_circuit Ub3(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(min_in),  //push botton input
    .pb_debounced(d_min)    //debounced push botton output
);

//debounce_circuit for lap_in
debounce_circuit Ub4(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(hour_in),  //push botton input
    .pb_debounced(d_hour)    //debounced push botton output
);

//one_pulse for d_start
one_pulse Ub5(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_start),
    .out_pulse(start_pulse)
);

//one_pulse for d_paus
one_pulse Ub6(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_pause),
    .out_pulse(pause_pulse)
);

//one_pulse for d_start
one_pulse Ub7(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_min),
    .out_pulse(min_pulse)
);

//one_pulse for d_paus
one_pulse Ub8(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(d_hour),
    .out_pulse(hour_pulse)
);

endmodule