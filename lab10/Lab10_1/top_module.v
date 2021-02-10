module top_module(
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_sdin,
    clk,
    rst_n
);
output audio_mclk;
output audio_lrck;
output audio_sck;
output audio_sdin;
input clk, rst_n;
wire [21:0] note_div;
wire clk_1;

clock_generator U0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(), //generated 100Hz clock
    .clk_ctl() //scan control
);

ring_counter U1(
    .note_div(note_div),
    .clk(clk_1),
    .rst_n(rst_n)
);

speaker U2(
    .vol(16'h0FFF),
    .vol_minus(16'h0000),
    .note_div(note_div),
    .clk(clk),
    .rst_n(rst_n),
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .audio_sck(audio_sck),
    .audio_sdin(audio_sdin)
);

endmodule
