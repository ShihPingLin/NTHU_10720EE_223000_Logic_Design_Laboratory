`timescale 1ns / 1ps

module test_Lab8_1;
wire audio_mclk, audio_lrck, audio_sck, audio_stdin;
reg [15:0] audio_left, audio_right;
reg clk, rst_n;

speaker_control Ut0(
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .audio_sck(audio_sck),
    .audio_stdin(audio_stdin),
    .audio_left(audio_left),
    .audio_right(audio_right),
    .clk(clk),
    .rst_n(rst_n)
);

initial
begin
    audio_left = 16'b1010101010101010;
    audio_right = 16'b0101010101010101;
    clk = 0;
    rst_n = 0;
    #150 rst_n = 1;
end

always
    #50 clk = ~clk;
    
endmodule