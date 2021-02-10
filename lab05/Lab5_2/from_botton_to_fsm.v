`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/25 17:09:39
// Design Name: 
// Module Name: from_botton_to_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module from_botton_to_fsm(
    count_enable,
    rst_n,
    clk,
    pb_in
);
output count_enable;
output rst_n;
input clk;
input pb_in;
wire clk_1;
wire clk_100;
wire led_pb;
wire led_1_pulse;
wire rst;
wire rst_tmp;
wire pb;

assign rst_n = ~rst_tmp;

clock_generator U0(
    .clk(clk),      //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(clk_100), //generated 100Hz clock
    .clk_ctl() //scan control
);

debounce_circuit U1(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(pb_in),  //push botton input
    .pb_debounced(led_pb)    //debounced push botton output
);

counter U2(
    .clk(clk_1),
    .in(led_pb),
    .pb(pb),
    .rst_n(rst_n),
    .rst(rst)
);

one_pulse U3(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(pb),
    .out_pulse(led_1_pulse)
);

one_pulse U4(
    .clk(clk),
    .rst_n(rst_n),
    .in_trig(rst),
    .out_pulse(rst_tmp)
);

fsm U5(
    .count_enable(count_enable),   //count or not
    .in(led_1_pulse),     //press or not
    .clk(clk),    //global clock
    .rst_n(rst_n)   //negative edge reset
);

endmodule
