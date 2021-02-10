`timescale 1ns / 1ps

module speaker_control(    
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_stdin,
    audio_left,
    audio_right,
    clk,
    rst_n
);
output audio_mclk, audio_lrck, audio_sck, audio_stdin;
input [15:0] audio_left, audio_right;
input clk, rst_n;
wire audio_sck;

frequency_divider U0(    
    .clk_mclk(audio_mclk),       //generated 25MHz clock
    .clk_lrck(audio_lrck),       //generated 25MHz/128 clock
    .clk_sck(audio_sck),         //generated 25MHz/4 clock
    .clk(clk),                   //clock from crystal
    .rst_n(rst_n)                //active low reset
);

parallel_to_serial U1(
    .audio_stdin(audio_stdin),
    .audio_left(audio_left),
    .audio_right(audio_right),
    .clk(audio_sck),              // 25MHz / 4
    .rst_n(rst_n)
);

endmodule
