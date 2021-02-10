`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 00:22:45
// Design Name: 
// Module Name: test_lab3_4_ver2
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

module test_lab3_4_ver2;
wire [7:0] D_ssd;
wire [3:0] ssd_ctl;
reg clk, rst_n;

top_module U_test(.clk(clk), .rst_n(rst_n), .D_ssd(D_ssd), .ssd_ctl(ssd_ctl));

initial
begin
    rst_n = 0;
    clk = 0;
    #100 rst_n = 1;
end

always
    #5 clk = ~clk;

endmodule