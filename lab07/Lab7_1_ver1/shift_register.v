`timescale 1ns / 1ps

module shift_register(
    rst,
    in,
    clk,
    rst_n
);
output rst;
input in;
input clk, rst_n;
reg rst;
reg [3:0] q; 

always @*
    if (q[3] == 1'b1 && q[2] == 1'b1 && q[1] == 1'b1 && q[0] == 1'b1)
        rst = 1'b1;
    else
        rst = 1'b0;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        q <= 4'b0000;
    else begin
        q[0] <= in;
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
    end

endmodule