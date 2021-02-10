//define segment codes
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001

module display(D_ssd, d, i);
output [7:0] D_ssd;
output [3:0] d;
input [3:0] i;
reg [7:0] D_ssd;
reg [3:0] d;

always @*
    d = i;

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
        default: D_ssd = 8'b01110001;
    endcase
endmodule