`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2019 05:46:29 PM
// Design Name: 
// Module Name: lab1_1
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


module full_adder(cout, s, x, y, cin);
output s, cout;
input x, y, cin;

assign cout = (x & y) | (x & cin) | (y & cin);
assign s = x ^ y ^ cin;

endmodule
