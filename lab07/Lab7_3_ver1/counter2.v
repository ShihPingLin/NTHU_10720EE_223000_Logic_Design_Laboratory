`timescale 1ns / 1ps

module counter2(
    min0,
    min1,
    hour0,
    hour1,
    min_ini,
    hour_ini,
    LED_control,
    clk,    //global clock
    rst_n,   //negative edge reset
    en,
    rst_state,
    setting
);
output [3:0] min0, min1, hour0, hour1;
output [15:0] LED_control;
input [5:0] min_ini, hour_ini;
input en, rst_state, setting;
input clk, rst_n;
wire br0, br1;
wire decrease_enable;

assign decrease_enable = en && (~((min0 == 4'd0) && (min1 == 4'd0) && (hour0 == 4'd0) && (hour1 == 4'd0)));
assign LED_control = (((min0 == 4'd0) && (min1 == 4'd0) && (hour0 == 4'd0) && (hour1 == 4'd0)) && (setting == 1'b0)) ? 16'b1111111111111111 : 16'd0;

//counter for second
down_counter Udc0(
    .value_1(),  //counter output
    .value_0(),
    .value_initial(6'd60),  //value after reset
    .borrow(br0), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .decrease(decrease_enable),   //counter enable control
    .limit(6'd59),   //limit for the counter
    .rst_state(rst_state)
);

//counter for minute
down_counter Udc1(
    .value_1(min1),  //counter output
    .value_0(min0),
    .value_initial(min_ini),  //value after reset
    .borrow(br1), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .decrease(br0),   //counter enable control
    .limit(6'd59),   //limit for the counter
    .rst_state(rst_state)
);

//counter for minute
down_counter Udc2(
    .value_1(hour1),  //counter output
    .value_0(hour0),
    .value_initial(hour_ini),  //value after reset
    .borrow(), //borrow indicator
    .clk(clk),    //divided clock
    .rst_n(rst_n),  //active low reset
    .decrease(br1),   //counter enable control
    .limit(6'd23),   //limit for the counter
    .rst_state(rst_state)
);

endmodule