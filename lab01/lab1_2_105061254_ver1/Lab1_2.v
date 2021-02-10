`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 08:01:25
// Design Name: 
// Module Name: Lab1_2
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


module adder(a, b, ci, s, co);
output [3:0] s;
output co;
input [3:0] a, b;
input ci;
reg [3:0]s;
reg co;

always @(a or b or ci)
begin
   if ((a + b + ci) > 9)
   begin
        {co, s} = a + b + ci + 6;
   end
   else
   begin
        {co, s} = a + b + ci;
    end
end
    
endmodule