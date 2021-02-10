`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 23:40:25
// Design Name: 
// Module Name: reset_botton
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


module reset_botton(
    clk_100,
    clk,
    rst_n,
    rst_in        
);
output rst_n;
input rst_in, clk_100, clk;
wire rst_n_tmp;
wire rst_mid;

assign rst_n = ~rst_n_tmp;

debounce_circuit Ur0(
    .clk(clk_100),
    .rst_n(rst_n),  //negative edge reset
    .pb_in(rst_in),  //push botton input
    .pb_debounced(rst_mid)    //debounced push botton output
);

one_pulse Ur1(
    .clk(clk),    //global clock
    .rst_n(rst_n),
    .in_trig(rst_mid),
    .out_pulse(rst_n_tmp)
);

endmodule
