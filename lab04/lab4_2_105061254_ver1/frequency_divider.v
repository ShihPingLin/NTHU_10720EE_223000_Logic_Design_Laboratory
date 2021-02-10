`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 19:36:19
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

module frequency_divider(
    clk,    //global clock
    rst_n,  //global rst
    clk_out //divider clock output
);
output clk_out;
input clk, rst_n;
reg clk_out;
reg clk_out_tmp;
reg T;
reg [26:0] q_tmp;
reg [26:0] q;

always @*
begin        
    q_tmp = q + 27'd1;
    
    if (q_tmp == 27'd50000000) begin
        q_tmp = 27'd0;
        T = 1'b1;
    end
    else
        T = 1'b0;
    
    clk_out_tmp = clk_out ^ T;
end

always @(posedge clk or negedge rst_n)    //D-FF for counter
begin
    if (~rst_n)
        q <= 27'd0;
    else
        q <= q_tmp;
end

always @(posedge clk or negedge rst_n)    //T-FF
begin
    if (~rst_n)
        clk_out <= 1'b0;
    else
        clk_out <= clk_out_tmp;
end

endmodule
