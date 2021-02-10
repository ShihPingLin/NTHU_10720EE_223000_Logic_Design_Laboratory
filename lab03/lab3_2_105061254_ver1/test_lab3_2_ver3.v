`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/07 21:37:15
// Design Name: 
// Module Name: test_lab3_2
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

module test_lab3_2;

wire clk_out;
reg clk;
reg rst;

frequency_divider_n U0(.clk_out(clk_out),.clk(clk),.rst(rst));

initial
begin
    rst = 0;
    clk = 0;
    #100 rst = 1;
    #1000 rst = 0;
    #2000 rst = 1;
end

always
    #5 clk = ~clk;

endmodule