`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/03 21:10:53
// Design Name: 
// Module Name: test_lab2_4
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


module test_lab2_4;
wire X;
wire [3:0] LED_A, LED_B;
reg [3:0] A, B;

comparator U0(.X(X),.LED_A(LED_A),.LED_B(LED_B),.A(A),.B(B));

initial
begin
A = 4'b0000; B = 4'b0001;
#10 A = 4'b1000; B = 4'b0100;
#10 A = 4'b0100; B = 4'b0100;
end

endmodule
