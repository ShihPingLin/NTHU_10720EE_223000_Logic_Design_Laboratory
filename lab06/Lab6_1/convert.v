`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/06 18:48:42
// Design Name: 
// Module Name: convert
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

`define PM 1'b1
`define AM 1'b0
module convert(
    hr0_24,
    hr1_24,
    hr0_12,
    hr1_12,
    point_tmp,
    value
);
output [3:0] hr0_24, hr1_24;
output [3:0] hr0_12, hr1_12;
output point_tmp;
input [4:0] value;
reg [3:0] hr0_24, hr1_24;
reg [3:0] hr0_12, hr1_12;
reg point_tmp;

always@*
    if(value >= 5'd12)
        point_tmp = `PM;
    else
        point_tmp = `AM;

always@*
    if (value >= 5'd20)
    begin
        hr1_24 = 4'd2;
        hr0_24 = value - 20;
    end
    else if (value >= 5'd10)
    begin
        hr1_24 = 4'd1;
        hr0_24 = value - 10;
    end
    else 
    begin
        hr1_24 = 4'd0;
        hr0_24 = value;
    end

always@*
    if (value >= 5'd22)
    begin
        hr1_12 = 4'd1;
        hr0_12 = value - 5'd22;
    end
    else if (value >= 5'd13)
    begin
        hr1_12 = 4'd0;
        hr0_12 = value - 5'd12;
    end
    else if (value == 5'd12 || value == 5'd0)
    begin
        hr1_12 = 4'd1;
        hr0_12 = 4'd2;
    end
    else if (value >= 5'd10)
    begin  
        hr1_12 = 4'd1;
        hr0_12 = value - 5'd10;
    end
    else 
    begin  
        hr1_12 = 4'd0;
        hr0_12 = value;
    end

endmodule