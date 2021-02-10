`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 12:31:29
// Design Name: 
// Module Name: debounce_circuit
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

module debounce_circuit(
    clk,    //global clock
    rst_n,  //negative edge reset
    pb_in,  //push botton input
    pb_debounced    //debounced push botton output
);

//declare the I/Os
input clk;
input rst_n;
input pb_in;
output pb_debounced;
reg pb_debounced;

//declare the internal nodes
reg [3:0] debounce_window;
reg pb_debounced_next;

//Shift register
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        debounce_window <= 4'd0;
    else
        debounce_window <= {debounce_window[2:0], pb_in};

//debounce circuit
always @*
    if (debounce_window == 4'b1111)
        pb_debounced_next <= 1'b1;
    else
        pb_debounced_next <= 1'b0;
        
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        pb_debounced <= 1'b0;
    else
        pb_debounced <= pb_debounced_next;

endmodule