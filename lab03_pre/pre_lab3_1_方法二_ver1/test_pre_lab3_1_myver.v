`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 00:51:27
// Design Name: 
// Module Name: test_pre_lab3_1_myver
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

module test_pre_lab3_1;
wire [3:0] q;
reg clk;
reg rst_n;

bincnt U0(.q(q),.clk(clk),.rst_n(rst_n));

initial
begin
    clk = 0;
    rst_n = 0;
    #100 rst_n = 1;
end

always
    #50 clk = ~clk;

endmodule
