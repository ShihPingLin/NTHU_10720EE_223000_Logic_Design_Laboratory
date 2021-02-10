`timescale 1ns / 1ps

module top_module(
    ssd_ctl,
    segs,
    point,
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_sdin,
    in_up,
    in_down,
    clk,
    rst_n
);
output [3:0] ssd_ctl;
output [6:0] segs;
output point;
output audio_mclk;
output audio_lrck;
output audio_sck;
output audio_sdin;
input in_up, in_down;
input clk, rst_n;
wire in_up_pulse, in_down_pulse;
wire [21:0] note_div;
wire [15:0] vol, vol_minus;
wire [4:0] state;
wire [1:0] clk_ctl;
wire [3:0] ssd_in;
wire [3:0] digit0, digit1;

assign point = 1'b1;

clock_generator U0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(),  //generated 1Hz clock
    .clk_100(), //generated 100Hz clock
    .clk_ctl(clk_ctl) //scan control
);

botton U1(
    .in_up_pulse(in_up_pulse),
    .in_down_pulse(in_down_pulse),
    .in_up(in_up),
    .in_down(in_down),
    .clk(clk),
    .rst_n(rst_n)
);    

fsm U2(
    .note_div(note_div),
    .vol(vol),
    .vol_minus(vol_minus),
    .state(state),  //for debug
    .in_up_pulse(in_up_pulse),
    .in_down_pulse(in_down_pulse),
    .clk(clk),        //global clock
    .rst_n(rst_n)     //negative edge reset
);

speaker U3(
    .vol(vol),
    .vol_minus(vol_minus),
    .note_div(note_div),
    .clk(clk),
    .rst_n(rst_n),
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .audio_sck(audio_sck),
    .audio_sdin(audio_sdin)
);

assign digit0 = state % 10;
assign digit1 = state / 10;

scan_ctl U4(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(4'b1111),        //1st input
    .in1(4'b1111),        //2nd input
    .in2(digit1),        //3rd input
    .in3(digit0),        //4th input
    .ssd_ctl_en(clk_ctl)  //divided clock for scan control
);

display U5(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);

endmodule
