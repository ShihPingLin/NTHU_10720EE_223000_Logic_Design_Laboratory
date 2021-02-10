`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 22:02:28
// Design Name: 
// Module Name: test_pre_Lab5
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


module test_pre_Lab5;
wire count_enable;
reg clk;
reg rst_n;
reg in;
fsm U0(
    .count_enable(count_enable),   //count or not
    .in(in),     //press or not
    .clk(clk),    //global clock
    .rst_n(rst_n)   //negative edge reset
);

initial
begin
    clk = 0;
    rst_n = 0;
    in = 0;
    #150 rst_n = 1;
    #100 in = 1;
    #100 in = 0;
    #500 in = 1;
    #100 in = 0;
    #650 in = 1;
    #100 in = 0;
    #500 in = 1;
    #100 in = 0;
end

always
    #50 clk = ~clk;
    
endmodule
