`timescale 1ns / 1ps

module test_top_module;

wire [7:0] q;
reg clk;
reg rst;

top_module U3(
    .q(q),
    .clk(clk),
    .rst(rst)
);

initial
begin
    clk = 0;
    rst = 0;
    #100 rst = 1;
    #1000 rst = 0;
    #1200 rst = 1;
end

always
    #50 clk = ~clk;
    
endmodule