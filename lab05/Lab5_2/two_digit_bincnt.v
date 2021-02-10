`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/15 12:57:33
// Design Name: 
// Module Name: two_digit_bincnt
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


module two_digit_bincnt(
    digit0, //digit in one
    digit1, //digit in ten
    LED_control,
    clk,    //global clock
    rst_n,   //negative edge reset
    en
);

output [3:0] digit0, digit1;
output [15:0] LED_control;
input clk, rst_n, en;
wire br0, br1;
wire decrease_enable;

assign decrease_enable = en && (~((digit0 == 4'b0) && (digit1 == 4'b0)));
assign LED_control = ((digit0 == 4'b0) && (digit1 == 4'b0)) ? 16'b1111111111111111 : 16'd0;

//30 sec down counter
down_counter Udc0(
    .value(digit0),  //counter output
    .value_initial(4'd0),  //value after reset
    .borrow(br0), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .decrease(decrease_enable),   //counter enable control
    .limit(4'd9)   //limit for the counter
);

down_counter Udc1(
    .value(digit1),  //counter output
    .value_initial(4'd3),  //value after reset
    .borrow(br1), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .decrease(br0),   //counter enable control
    .limit(4'd5)   //limit for the counter
);

endmodule