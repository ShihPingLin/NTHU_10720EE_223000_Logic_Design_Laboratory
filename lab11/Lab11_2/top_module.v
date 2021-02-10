module top_module(
    vgaRed,
    vgaGreen,
    vgaBlue,
    hsync,
    vsync,
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
//VGA
output [3:0] vgaRed;
output [3:0] vgaGreen;
output [3:0] vgaBlue;
output hsync;
output vsync;
//calculator
output [3:0] operator;
output [3:0] state;
output [6:0] segs;
output [3:0] ssd_ctl;
output point;
inout PS2_DATA;
inout PS2_CLK;
input rst, clk;

//VGA
wire [11:0] data;
wire clk_25MHz;
wire clk_22;
wire [16:0] pixel_addr;
wire [11:0] pixel;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480
//calculator
wire key_valid;
wire [511:0] key_down;
wire [8:0] last_change;
wire [1:0] clk_ctl;
wire [3:0] ssd_in;
wire [3:0] digit;
wire [3:0] digit0, digit1, digit2, digit3;
wire [3:0] digit4, digit5, digit6, digit7;
wire [3:0] operator;

assign point = 1'b1;
assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

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
    .digit7(digit7),
    .digit6(digit6),
    .digit5(digit5),
    .digit4(digit4),
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

// Frequency Divider
clock_divisor clk_wiz_0_inst(
  .clk(clk),
  .clk1(clk_25MHz),
  .clk22(clk_22)
);

// Reduce frame address from 640x480 to 320x240
mem_addr_gen mem_addr_gen_inst(
  .clk(clk_22),
  .rst(~rst),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
  .pixel_addr(pixel_addr),
  .digit0(digit0),
  .digit1(digit1),
  .digit2(digit2),
  .digit3(digit3),
  .digit4(digit4),
  .digit5(digit5),
  .digit6(digit6),
  .digit7(digit7),
  .operator(operator)
);
     
// Use reduced 320x240 address to output the saved picture from RAM 
blk_mem_gen_0 blk_mem_gen_0_inst(
  .clka(clk_25MHz),
  .wea(0),
  .addra(pixel_addr),
  .dina(data[11:0]),
  .douta(pixel)
); 

// Render the picture by VGA controller
vga_controller   vga_inst(
  .pclk(clk_25MHz),
  .reset(~rst),
  .hsync(hsync),
  .vsync(vsync),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt)
);
      
endmodule