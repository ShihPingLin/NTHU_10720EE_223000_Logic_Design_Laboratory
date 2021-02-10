module top(
  input en,
  input clk,
  input rst_n,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync
);
wire rst;
wire [11:0] data;
wire clk_25MHz;
wire clk_22;
wire [16:0] pixel_addr;
wire [11:0] pixel;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480
wire d_en, en_pulse, enable;

assign rst = ~rst_n;
assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

debounce_circuit U0(
    .clk(clk),    //global clock
    .rst_n(rst),  //negative edge reset
    .pb_in(en),  //push botton input
    .pb_debounced(d_en)    //debounced push botton output
);

one_pulse U1(
    .clk(clk),
    .rst_n(rst),
    .in_trig(d_en),
    .out_pulse(en_pulse)
);

fsm U2(
    .enable(enable),
    .en_pulse(en_pulse),
    .clk(clk),
    .rst_n(rst)
);

// Frequency Divider
clock_divisor clk_wiz_0_inst(
  .clk(clk),
  .clk1(clk_25MHz),
  .clk22(clk_22)
);

// Reduce frame address from 640x480 to 320x240
mem_addr_gen mem_addr_gen_inst(
  .enable(enable),
  .clk(clk_22),
  .rst(~rst),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
  .pixel_addr(pixel_addr)
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
