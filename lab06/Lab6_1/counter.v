`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 17:44:33
// Design Name: 
// Module Name: counter
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

module counter(
    sec0,
    sec1,
    min0,
    min1,
    hr0_24,
    hr1_24,
    hr0_12,
    hr1_12,
    point_tmp,
    clk,    //global clock
    rst_n   //negative edge reset
);
output [3:0] sec0, sec1;
output [3:0] min0, min1;
output [3:0] hr0_24, hr1_24, hr0_12, hr1_12;
output point_tmp;
input clk, rst_n;
wire c0, c1, c2, c3;
wire [4:0] hr;

Up_counter Udc0(
    .value(sec0),  //counter output
    .value_initial(4'd0),  //value after reset
    .carry(c0), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .increase(1'b1),   //counter enable control
    .limit(4'd9)   //limit for the counter
);

Up_counter Udc1(
    .value(sec1),  //counter output
    .value_initial(4'd0),  //value after reset
    .carry(c1), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .increase(c0),   //counter enable control
    .limit(4'd5)   //limit for the counter
);

Up_counter Udc2(
    .value(min0),  //counter output
    .value_initial(4'd0),  //value after reset
    .carry(c2), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .increase(c1),   //counter enable control
    .limit(4'd9)   //limit for the counter
);

Up_counter Udc3(
    .value(min1),  //counter output
    .value_initial(4'd0),  //value after reset
    .carry(c3), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .increase(c2),   //counter enable control
    .limit(4'd5)   //limit for the counter
);

Up_counter_2 Udc4(
    .value(hr),  //counter output
    .value_initial(5'd0),  //value after reset
    .clk(clk),    //global clock
    .rst_n(rst_n),  //active low reset
    .increase(c3),   //counter enable control
    .limit(5'd23)   //limit for the counter
);

convert Udc5(
    .hr0_24(hr0_24),
    .hr1_24(hr1_24),
    .hr0_12(hr0_12),
    .hr1_12(hr1_12),
    .point_tmp(point_tmp),
    .value(hr)
);

endmodule