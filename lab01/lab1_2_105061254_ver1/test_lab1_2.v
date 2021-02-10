`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 08:20:49
// Design Name: 
// Module Name: test_lab1_2
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


module test_adder;
wire [3:0] S;
wire CO;
reg [3:0] A, B;
reg CI;
integer i, j, k;
adder U0(.s(S),.co(CO),.a(A),.b(B),.ci(CI));

initial
begin
    A = 0; B = 0; CI = 0;
    for (i = 0; i <= 9; i = i + 1)
        for (j = 0; j <= 9; j = j + 1)
            for (k = 0; k <= 1; k = k + 1)
            begin
                if (i != 0 || j != 0 || k != 0)
                    #10 A = i; B = j; CI = k;
            end
end 
endmodule
