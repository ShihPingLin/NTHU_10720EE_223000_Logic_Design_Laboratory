`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 01:19:44
// Design Name: 
// Module Name: test_pre_lab3_2
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


module test_pre_lab3_2;

wire [7:0] q;
reg clk;
reg rst_n;

shifter U0(.q(q),.clk(clk),.rst_n(rst_n));

initial
begin
    clk = 0;
    rst_n = 0;
    #100 rst_n = 1;
end

always
    #50 clk = ~clk;
    
endmodule
