`timescale 1ns / 1ps

module top_module(
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_sdin,
    in_do,
    in_re,
    in_mi,
    clk,
    rst_n
);
output audio_mclk;
output audio_lrck;
output audio_sck;
output audio_sdin;
input in_do, in_re, in_mi;
input clk, rst_n;
wire d_in_do, d_in_re, d_in_mi;
wire [21:0] note_div;
wire [15:0] vol, vol_minus;

botton U0(
    .d_in_do(d_in_do),
    .d_in_re(d_in_re),
    .d_in_mi(d_in_mi),
    .in_do(in_do),
    .in_re(in_re),
    .in_mi(in_mi),
    .clk(clk),
    .rst_n(rst_n)
);    

MUX U1(
    .note_div(note_div),
    .vol(vol),
    .vol_minus(vol_minus),
    .d_in_do(d_in_do),
    .d_in_re(d_in_re),
    .d_in_mi(d_in_mi)
);

speaker U2(
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

endmodule