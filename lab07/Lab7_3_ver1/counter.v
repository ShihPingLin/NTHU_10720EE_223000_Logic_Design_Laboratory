`timescale 1ns / 1ps

module counter(
    sec0,
    sec1,
    min0,
    min1,
    count_enable,
    rst_state,
    clk,    //global clock
    rst_n   //negative edge reset
);
output [3:0] sec0, sec1;
output [3:0] min0, min1;
input count_enable, rst_state;
input clk, rst_n;
wire c0, c1, c2;

Up_counter Udc0(
    .value(sec0),  //counter output
    .value_initial(4'd0),  //value after reset
    .carry(c0), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .increase(count_enable),   //counter enable control
    .limit(4'd9),   //limit for the counter
    .rst_state(rst_state)
);

Up_counter Udc1(
    .value(sec1),  //counter output
    .value_initial(4'd0),  //value after reset
    .carry(c1), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .increase(c0),   //counter enable control
    .limit(4'd5),   //limit for the counter
    .rst_state(rst_state)
);

Up_counter Udc2(
    .value(min0),  //counter output
    .value_initial(4'd0),  //value after reset
    .carry(c2), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .increase(c1),   //counter enable control
    .limit(4'd9),   //limit for the counter
    .rst_state(rst_state)
);

Up_counter Udc3(
    .value(min1),  //counter output
    .value_initial(4'd0),  //value after reset
    .carry(c3), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .increase(c2),   //counter enable control
    .limit(4'd5),   //limit for the counter
    .rst_state(rst_state)
);

endmodule