`timescale 1ns / 1ps

//define segment codes
`define SS_0 7'b0000001
`define SS_1 7'b1001111
`define SS_2 7'b0010010
`define SS_3 7'b0000110
`define SS_4 7'b1001100
`define SS_5 7'b0100100
`define SS_6 7'b0100000
`define SS_7 7'b0001111
`define SS_8 7'b0000000
`define SS_9 7'b0000100

module display(
    D_ssd,  //seven_segment output
    i       //input counter value
);
output [6:0] D_ssd;
input [3:0] i;
reg [6:0] D_ssd;

always @*
    case(i)
        4'd0:D_ssd = `SS_0;
        4'd1:D_ssd = `SS_1;
        4'd2:D_ssd = `SS_2;
        4'd3:D_ssd = `SS_3;
        4'd4:D_ssd = `SS_4;
        4'd5:D_ssd = `SS_5;
        4'd6:D_ssd = `SS_6;
        4'd7:D_ssd = `SS_7;
        4'd8:D_ssd = `SS_8;
        4'd9: D_ssd = `SS_9;
        default: D_ssd = 7'b1111111;
    endcase

endmodule