`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/03 21:01:16
// Design Name: 
// Module Name: lab2_4
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


module comparator(A, B, X, LED_A, LED_B);
output X;
output [3:0] LED_A, LED_B;
input [3:0] A, B;
reg X;
reg [3:0] LED_A, LED_B;

always @*
begin
    LED_A = A;
    LED_B = B;
    
    if (A <= B)
        X = 0;
    else
        X = 1; 
end

endmodule
