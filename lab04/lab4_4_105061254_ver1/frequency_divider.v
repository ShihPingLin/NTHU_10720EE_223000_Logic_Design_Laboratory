`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/15 12:51:06
// Design Name: 
// Module Name: frequency_divider
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

module freqency_divider(
    clk_out,    //divided clock output
    clk_ctl,    //divided clock output for scan frequency
    clk,        //global clock input
    rst_n       //active low reset
);
output clk_out;
output [1:0] clk_ctl;
input clk, rst_n;
reg clk_out;
reg [1:0] clk_ctl, clk_ctl_tmp;
reg clk_out_tmp;
reg T;
reg [26:0] q_tmp, q_tmp2;
reg [26:0] q, q2;

always @*
begin        
    q_tmp = q + 27'd1;
    q_tmp2 = q2 + 27'd1;
    
    if (q_tmp == 27'd50000000) begin        //q has already count from 0 to 49999999(50M times)
        q_tmp = 27'd0;
        T = 1'b1;
    end
    else
        T = 1'b0;
    
    if (q_tmp2 == 27'd100000) begin
        clk_ctl_tmp = clk_ctl + 1;
        q_tmp2 = 0;
    end
    else
        clk_ctl_tmp = clk_ctl;
    
    clk_out_tmp = clk_out ^ T;
end

always @(posedge clk or negedge rst_n)    //D-FF for counter
begin
    if (~rst_n)
    begin
        q <= 27'd0;
        q2 <= 27'd0;
        clk_ctl <= 2'b0;
    end
    else
    begin
        q <= q_tmp;
        q2 <= q_tmp2;
        clk_ctl <= clk_ctl_tmp;
    end
end

always @(posedge clk or negedge rst_n)    //T-FF
begin
    if (~rst_n)
        clk_out <= 1'b0;
    else
        clk_out <= clk_out_tmp;
end

endmodule