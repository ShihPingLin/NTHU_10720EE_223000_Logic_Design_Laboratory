`timescale 1ns / 1ps

module speaker(
    vol,
    vol_minus,
    note_div,
    clk,
    rst_n,
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_sdin
);
input [15:0] vol, vol_minus;
input [21:0] note_div;
input clk;
input rst_n;
output audio_mclk;
output audio_lrck;
output audio_sck;
output audio_sdin;
wire [15:0] audio_in_left, audio_in_right;

buzzer_control Ung(
    .clk(clk),
    .rst_n(rst_n),
    .vol(vol),                //change the volume
    .vol_minus(vol_minus),    //change the volume
    .note_div(note_div),      //change the sound frequency
    .audio_left(audio_in_left),
    .audio_right(audio_in_right)
);

speaker_control Usc(    
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .audio_sck(audio_sck),
    .audio_stdin(audio_sdin),
    .audio_left(audio_in_left),
    .audio_right(audio_in_right),
    .clk(clk),
    .rst_n(rst_n)
);

endmodule