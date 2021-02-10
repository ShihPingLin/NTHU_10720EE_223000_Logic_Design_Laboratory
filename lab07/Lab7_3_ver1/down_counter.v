`timescale 1ns / 1ps

module down_counter(
    value_1,  //counter output
    value_0,
    value_initial,  //value after reset
    borrow, //borrow indicator
    clk,    //global clock
    rst_n,  //active low reset
    decrease,   //counter enable control
    limit,   //limit for the counter
    rst_state
);
output [3:0] value_1, value_0;
output borrow;
input [5:0] value_initial;
input [5:0] limit;
input decrease, rst_state;
input clk, rst_n;
reg [3:0] value_1, value_0;
reg [5:0] value, value_tmp;
reg borrow;

always @*
    if (rst_state == 1'b1) begin
        value_tmp = value_initial;
        borrow = 0;
    end
    else if (value == 6'd0 && decrease && rst_state == 1'b0)
    begin
        value_tmp = limit;
        borrow = 1;
    end
    else if (value != 6'd0 && decrease && rst_state == 1'b0)
    begin
        value_tmp = value - 6'd1;
        borrow = 0;
    end
    else
    begin
        value_tmp = value;
        borrow = 0;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value <= 6'd0;
    else
        value <= value_tmp;

//convert to two separate digits
always@*
begin
    value_1 = value / 10;
    value_0 = value % 10;
end
 
endmodule