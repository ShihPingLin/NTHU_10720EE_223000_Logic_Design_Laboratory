`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/28 22:10:26
// Design Name: 
// Module Name: three_digit_bincnt
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

module three_digit_bincnt(
    digit0, //digit in one
    digit1, //digit in ten
    digit2, //digit in hundred
    initial_1,
    initial_10,
    initial_100,
    LED_control,
    clk,    //global clock
    rst_n,  //negative edge reset
    en
);

output [3:0] digit0, digit1, digit2;
output [15:0] LED_control;
input clk, rst_n, en;
input [3:0] initial_1, initial_10, initial_100;
wire br0, br1, br2;
wire decrease_enable;

assign decrease_enable = en && (~((digit0 == 4'b0) && (digit1 == 4'b0) && (digit2 == 4'd0)));
assign LED_control = ((digit0 == 4'b0) && (digit1 == 4'b0) && (digit2 == 4'b0)) ? 16'b1111111111111111 : 16'd0;

//30 sec down counter
down_counter_2 Udc0(
    .value_2(digit0),  //counter output
    .value_initial(initial_1),  //value after reset
    .borrow_2(br0), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .decrease(decrease_enable),   //counter enable control
    .limit(4'd9)   //limit for the counter
);

down_counter_2 Udc1(
    .value_2(digit1),  //counter output
    .value_initial(initial_10),  //value after reset
    .borrow_2(br1), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .decrease(br0),   //counter enable control
    .limit(4'd5)   //limit for the counter
);

down_counter_2 Udc2(
    .value_2(digit2),  //counter output
    .value_initial(initial_100),  //value after reset
    .borrow_2(br2), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .decrease(br1),   //counter enable control
    .limit(4'd1)   //limit for the counter
);

endmodule