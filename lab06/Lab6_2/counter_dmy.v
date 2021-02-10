`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 22:35:13
// Design Name: 
// Module Name: counter_dmy
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


module counter_dmy(
    day0,
    day1,
    month0,
    month1,
    year0,
    year1,
    clk,
    rst_n
);
output [3:0] day0, day1;
output [3:0] month0, month1;
output [3:0] year0, year1;
input clk, rst_n;
wire c0, c1;
wire [4:0] limit_for_day;

Up_counter_day U0(
    .day0(day0),               //counter output
    .day1(day1),
    .carry(c0),                //borrow indicator    
    .value_initial(5'd1),      //value after reset
    .clk(clk),                 //global clock
    .rst_n(rst_n),             //active low reset
    .increase(1'b1),           //counter enable control
    .limit(limit_for_day)      //limit for the counter
);

Up_counter_month U1(
    .limit_for_day(limit_for_day),   //output used to identify the limit of day
    .month0(month0),                 //counter output
    .month1(month1),
    .carry(c1),                      //borrow indicator    
    .value_initial(4'd1),            //value after reset
    .clk(clk),                       //global clock
    .rst_n(rst_n),                   //active low reset
    .increase(c0),                   //counter enable control
    .limit(4'd12)                    //limit for the counter
);

Up_counter_year U2(
    .year0(year0),              //counter output
    .year1(year1),
    .value_initial(7'd0),      //value after reset
    .clk(clk),                //global clock
    .rst_n(rst_n),              //active low reset
    .increase(c1),           //counter enable control
    .limit(7'd99)               //limit for the counter
);

endmodule
