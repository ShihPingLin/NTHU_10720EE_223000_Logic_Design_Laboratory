module top_module(
    capital,
    segs,
    ssd_ctl,
    point,
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_sdin,
    PS2_DATA,
    PS2_CLK,
    rst,
    clk
);
output capital;
output [6:0] segs;
output [3:0] ssd_ctl;
output point;
output audio_mclk;
output audio_lrck;
output audio_sck;
output audio_sdin;
inout PS2_DATA;
inout PS2_CLK;
input rst, clk;
wire [8:0] last_change;
wire [511:0] key_down;
wire [1:0] clk_ctl;
wire [3:0] ssd_in;
wire [4:0] digit;
wire [3:0] digit0, digit1, digit2, digit3;
wire capital;
wire [6:0] value;
wire [21:0] note_div;

assign point = 1'b1;

KeyboardDecoder U0(
	.key_down(key_down),
	.last_change(last_change),
	.key_valid(),
	.PS2_DATA(PS2_DATA),
	.PS2_CLK(PS2_CLK),
	.rst(~rst),
	.clk(clk)
);

clock_generator U1(
    .clk(clk),    //clock from crystal
    .rst_n(rst),  //active low reset
    .clk_1(),  //generated 1Hz clock
    .clk_100(), //generated 100Hz clock
    .clk_ctl(clk_ctl) //scan control
);

decoder U2(
    .digit(digit),
    .last_change(last_change),
    .rst_n(rst),
    .clk(clk)
);

fsm U3(
    .capital(capital),
    .digit(digit),
    .key_down(key_down),
    .clk(clk),
    .rst_n(rst)
);

MUX U4(
    .digit0(digit0),
    .capital(capital),
    .value(value),
    .digit(digit),
    .key_down(key_down)
);

scan_ctl U5(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(4'b1111),        //1st input
    .in1(4'b1111),        //2nd input
    .in2(4'b1111),        //3rd input
    .in3(digit0),        //4th input
    .ssd_ctl_en(clk_ctl)  //divided clock for scan control
);

display U6(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);

MUX_for_speaker U7(
    .value(value),
    .note_div(note_div)
);

speaker U8(
    .vol(16'h0FFF),
    .vol_minus(16'h0000),
    .note_div(note_div),
    .clk(clk),
    .rst_n(rst),
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .audio_sck(audio_sck),
    .audio_sdin(audio_sdin)
);

endmodule