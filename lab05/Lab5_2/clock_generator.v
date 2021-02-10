`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 21:23:33
// Design Name: 
// Module Name: clock_generator
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


module clock_generator(
    clk,    //clock from crystal
    rst_n,  //active low reset
    clk_1,  //generated 1Hz clock
    clk_100, //generated 100Hz clock
    clk_ctl //scan control
);
input clk;
input rst_n;
output clk_1;
output clk_100;
output [1:0] clk_ctl;
reg clk_1;
reg clk_100;
reg [1:0] clk_ctl;

reg [26:0] count_50M, count_50M_next;
reg [26:0] count_500k, count_500k_next;
reg [26:0] count_100k, count_100k_next;
reg clk_1_next;
reg clk_100_next;
reg [1:0] clk_ctl_next;

always @*
    if (count_100k == 27'd100000)   //for display
    begin
        count_100k_next = 27'd0;
        clk_ctl_next = clk_ctl + 2'b1;
    end
    else
    begin
        count_100k_next = count_100k + 1'b1;
        clk_ctl_next = clk_ctl;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        count_100k <= 27'd0;
        clk_ctl <= 2'b0;
    end
    else
    begin
        count_100k <= count_100k_next;
        clk_ctl <= clk_ctl_next;
    end
 
always @*
    if (count_50M == 27'd50000000)
    begin
        count_50M_next = 27'd0;
        clk_1_next = ~clk_1;
    end
    else
    begin
        count_50M_next = count_50M + 1'b1;
        clk_1_next = clk_1;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        count_50M <= 27'd0;
        clk_1 <= 1'b0;
    end
    else
    begin
        count_50M <= count_50M_next;
        clk_1 <= clk_1_next;
    end

always @*
    if (count_500k == 27'd500000)
    begin
        count_500k_next = 27'd0;
        clk_100_next = ~clk_100;
    end
    else
    begin
        count_500k_next = count_500k + 1'b1;
        clk_100_next = clk_100;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        count_500k <= 27'd0;
        clk_100 <= 1'b0;
    end
    else
    begin
        count_500k <= count_500k_next;
        clk_100 <= clk_100_next;
    end
endmodule

