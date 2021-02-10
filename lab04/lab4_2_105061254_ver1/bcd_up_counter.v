`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 19:07:02
// Design Name: 
// Module Name: bcd_up_counter
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


module bcd_up_counter(
    value,  //count result
    rst_n,  //global reset
    clk     //divided clock
);
output [3:0] value;
input rst_n, clk;
reg [3:0] value;
reg [3:0] value_tmp;    //the next_state of value

always @*
    if (value >= 9)
        value_tmp = 4'd0;
    else
        value_tmp = value + 1;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        value <= 4'd0;
    else
        value <= value_tmp;

endmodule
