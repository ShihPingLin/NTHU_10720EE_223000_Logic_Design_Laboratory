`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 14:37:28
// Design Name: 
// Module Name: test_lab1_3
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


module test_decoder;

wire [7:0] D;
reg [2:0] IN;
reg EN;

decoder U0(.d(D), .in(IN), .en(EN));

initial
begin
    EN = 0; IN[2] = 0; IN[1] = 0; IN[0] = 0;
    #10 EN = 0; IN[2] = 0; IN[1] = 0; IN[0] = 1;
    #10 EN = 0; IN[2] = 0; IN[1] = 1; IN[0] = 0;
    #10 EN = 0; IN[2] = 0; IN[1] = 1; IN[0] = 1;
    #10 EN = 0; IN[2] = 1; IN[1] = 0; IN[0] = 0;
    #10 EN = 0; IN[2] = 1; IN[1] = 0; IN[0] = 1;
    #10 EN = 0; IN[2] = 1; IN[1] = 1; IN[0] = 0;
    #10 EN = 0; IN[2] = 1; IN[1] = 1; IN[0] = 1;
    #10 EN = 1; IN[2] = 0; IN[1] = 0; IN[0] = 0;
    #10 EN = 1; IN[2] = 0; IN[1] = 0; IN[0] = 1;
    #10 EN = 1; IN[2] = 0; IN[1] = 1; IN[0] = 0;
    #10 EN = 1; IN[2] = 0; IN[1] = 1; IN[0] = 1;
    #10 EN = 1; IN[2] = 1; IN[1] = 0; IN[0] = 0;
    #10 EN = 1; IN[2] = 1; IN[1] = 0; IN[0] = 1;
    #10 EN = 1; IN[2] = 1; IN[1] = 1; IN[0] = 0;
    #10 EN = 1; IN[2] = 1; IN[1] = 1; IN[0] = 1;
end
endmodule
