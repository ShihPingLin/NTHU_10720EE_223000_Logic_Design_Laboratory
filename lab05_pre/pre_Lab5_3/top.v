`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 21:43:07
// Design Name: 
// Module Name: top
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


module top(
    clk,    //clock from crystal
    rst_in, //change rst_n to rst_in
    pb_in,  //push button input
    count_enable
//    led_1pulse  //LED display output
);
input clk;
input rst_in;    //change rst_n to rst_in
input pb_in;
//output led_1pulse;
output count_enable;

wire led_pb;
wire clk_100, clk_1;
wire pb_debounced;
wire led_1pulse;
wire rst_n;

clock_generator U0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_1),  //generated 1Hz clock
    .clk_100(clk_100) //generated 100Hz clock
);

debounce_circuit U1(
    .clk(clk_100),    //global clock
    .rst_n(rst_n),  //negative edge reset
    .pb_in(pb_in),  //push botton input
    .pb_debounced(led_pb)    //debounced push botton output
);

one_pulse U2(
    .clk(clk),    //global clock
    .rst_n(rst_n),
    .in_trig(led_pb),
    .out_pulse(led_1pulse)
);

fsm U3(
    .count_enable(count_enable),   //count or not
    .in(led_1pulse),     //press or not
    .clk(clk),    //global clock
    .rst_n(rst_n)   //negative edge reset
);

reset_botton U4(
    .clk_100(clk_100),
    .clk(clk),
    .rst_n(rst_n),
    .rst_in(rst_in)        
);

endmodule