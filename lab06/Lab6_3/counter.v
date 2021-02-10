`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 11:22:35
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
    day0,
    day1,
    month0,
    month1,
    year0,
    year1,
    year2,
    year3,
    point_tmp,
    clk,    //global clock
    rst_n   //negative edge reset
);
output [3:0] sec0, sec1;
output [3:0] min0, min1;
output [3:0] hr0_24, hr1_24, hr0_12, hr1_12;
output [3:0] day0, day1;
output [3:0] month0, month1;
output [3:0] year0, year1, year2, year3;
output point_tmp;
input clk, rst_n;
wire c0, c1, c2, c3, c4, c5, c6;
wire [4:0] hr;
wire [4:0] limit_for_day, limit_for_Feb;

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
    .carry(c4),
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

Up_counter_day Udc6(
    .day0(day0),               //counter output
    .day1(day1),
    .carry(c5),                //borrow indicator    
    .value_initial(5'd1),      //value after reset
    .clk(clk),                 //global clock
    .rst_n(rst_n),             //active low reset
    .increase(c4),           //counter enable control
    .limit(limit_for_day)      //limit for the counter
);

Up_counter_month Udc7(
    .limit_for_day(limit_for_day),   //output used to identify the limit of day
    .month0(month0),                 //counter output
    .month1(month1),
    .carry(c6),                      //borrow indicator    
    .value_initial(4'd1),            //value after reset
    .clk(clk),                       //global clock
    .rst_n(rst_n),                   //active low reset
    .increase(c5),                   //counter enable control
    .limit(4'd12),                    //limit for the counter
    .limit_for_Feb(limit_for_Feb)
);

Up_counter_year Udc8(
    .year0(year0),              //counter output
    .year1(year1),
    .year2(year2),
    .year3(year3),    
    .limit_for_Feb(limit_for_Feb),
    .value_initial(12'd2000),      //value after reset
    .clk(clk),                //global clock
    .rst_n(rst_n),              //active low reset
    .increase(c6),           //counter enable control
    .limit(12'd2200)               //limit for the counter
);

endmodule
