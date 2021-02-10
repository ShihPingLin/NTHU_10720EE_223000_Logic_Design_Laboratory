module top_module(
    operator,
    state,
    segs,
    ssd_ctl,
    point,
    PS2_DATA,
    PS2_CLK,
    rst,
    clk
);
output [3:0] operator;
output [3:0] state;
output [6:0] segs;
output [3:0] ssd_ctl;
output point;
inout PS2_DATA;
inout PS2_CLK;
input rst, clk;
wire key_valid;
wire [511:0] key_down;
wire [8:0] last_change;
wire [1:0] clk_ctl;
wire [3:0] ssd_in;
wire [3:0] digit;
wire [3:0] digit0, digit1, digit2, digit3;

assign point = 1'b1;

KeyboardDecoder U0(
	.key_down(key_down),
	.last_change(last_change),
	.key_valid(key_valid),
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
    .state(state),
    .operator(operator),
    .digit3(digit3),
    .digit2(digit2),
    .digit1(digit1),
    .digit0(digit0),
    .digit(digit),
    .key_down(key_down),
    .clk(clk),
    .rst_n(rst)
);

scan_ctl U4(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(digit3),        //1st input
    .in1(digit2),        //2nd input
    .in2(digit1),        //3rd input
    .in3(digit0),        //4th input
    .ssd_ctl_en(clk_ctl)  //divided clock for scan control
);

display U5(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);

endmodule