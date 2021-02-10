`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 19:42:09
// Design Name: 
// Module Name: top_module
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


module top_module(
    ssd_ctl,
    D_ssd,
    rst_n,
    clk
);
output [3:0] ssd_ctl;
output [7:0] D_ssd;
input rst_n;
input clk;
wire clk_out;
wire [3:0] value;

assign ssd_ctl = 4'b1110;

frequency_divider U0(
    .clk(clk),      //global clock
    .rst_n(rst_n),  //global rst
    .clk_out(clk_out) //divider clock output
);

bcd_up_counter U1(
    .value(value),  //count result
    .rst_n(rst_n),  //global reset
    .clk(clk_out)     //divided clock
);

display U2(
    .D_ssd(D_ssd),  //seven_segment output
    .i(value)       //input counter value
);

endmodule
