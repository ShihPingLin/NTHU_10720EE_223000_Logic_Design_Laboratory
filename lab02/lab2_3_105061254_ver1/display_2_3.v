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
`define SS_a 8'b00010001
`define SS_b 8'b11000001
`define SS_c 8'b11100101
`define SS_d 8'b10000101
`define SS_e 8'b01100001
`define SS_f 8'b01110001

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
        4'h0:D_ssd = `SS_0;
        4'h1:D_ssd = `SS_1;
        4'h2:D_ssd = `SS_2;
        4'h3:D_ssd = `SS_3;
        4'h4:D_ssd = `SS_4;
        4'h5:D_ssd = `SS_5;
        4'h6:D_ssd = `SS_6;
        4'h7:D_ssd = `SS_7;
        4'h8:D_ssd = `SS_8;
        4'h9:D_ssd = `SS_9;
        4'ha:D_ssd = `SS_a;
        4'hb:D_ssd = `SS_b;
        4'hc:D_ssd = `SS_c;
        4'hd:D_ssd = `SS_d;
        4'he:D_ssd = `SS_e;
        4'hf:D_ssd = `SS_f;
        default: D_ssd = 8'b01110001;
    endcase
endmodule