`timescale 1ns / 1ps
`timescale 1ns / 1ps

module Up_counter(
    value,  //counter output
    value_initial,  //value after reset
    carry, //borrow indicator
    clk,    //global clock
    rst_n,  //active low reset
    increase,   //counter enable control
    limit,   //limit for the counter
    rst_state
);
output [3:0] value;
output carry;
input [3:0] value_initial;
input [3:0] limit;
input clk, rst_n, increase;
input rst_state;
reg [3:0] value, value_tmp;
reg carry;

always @*
    if (rst_state == 1'b1) begin
        value_tmp = value_initial;
        carry = 0;
    end
    else if (value == limit && increase && rst_state == 1'b0)
    begin
        value_tmp = 4'd0;
        carry = 1;
    end
    else if (value != limit && increase && rst_state == 1'b0)
    begin
        value_tmp = value + 4'd1;
        carry = 0;
    end
    else
    begin
        value_tmp = value;
        carry = 0;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value <= value_initial;
    else
        value <= value_tmp;
 
endmodule