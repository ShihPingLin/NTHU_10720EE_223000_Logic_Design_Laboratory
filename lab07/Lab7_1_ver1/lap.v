`timescale 1ns / 1ps

module MUX(
    digit0,
    digit1,
    digit2,
    digit3,
    rst_state,
    lap,
    sec0,
    sec1,
    min0,
    min1,
    clk,
    rst_n
);
output [3:0] digit0, digit1, digit2, digit3;
input lap, rst_state;
input [3:0] sec0, sec1;
input [3:0] min0, min1;
input clk, rst_n;
reg [3:0] digit0, digit1, digit2, digit3;
reg [3:0] digit0_tmp, digit1_tmp, digit2_tmp, digit3_tmp;

always @*
    if (rst_state == 1) begin
        digit0_tmp = 4'd0;
        digit1_tmp = 4'd0;
        digit2_tmp = 4'd0;
        digit3_tmp = 4'd0;
    end
    else if (rst_state == 0 && lap == 1) begin
        digit0_tmp = digit0;
        digit1_tmp = digit1;
        digit2_tmp = digit2;
        digit3_tmp = digit3;
    end
    else begin
        digit0_tmp = sec0;
        digit1_tmp = sec1;
        digit2_tmp = min0;
        digit3_tmp = min1;
    end
    
always @(posedge clk or negedge rst_n)
    if (~rst_n) begin
        digit0 <= 4'd0;
        digit1 <= 4'd0;
        digit2 <= 4'd0;
        digit3 <= 4'd0;
    end
    else begin
        digit0 <= digit0_tmp;
        digit1 <= digit1_tmp;
        digit2 <= digit2_tmp;
        digit3 <= digit3_tmp;
    end

endmodule
