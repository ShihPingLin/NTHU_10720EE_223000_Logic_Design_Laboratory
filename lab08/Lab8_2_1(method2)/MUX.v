`timescale 1ns / 1ps

module MUX(
    note_div,
    vol,
    vol_minus,
    d_in_do,
    d_in_re,
    d_in_mi    
);
output [21:0] note_div;
output [15:0] vol, vol_minus;
input d_in_do, d_in_re, d_in_mi;
reg [21:0] note_div;
reg [15:0] vol, vol_minus;

always @*
    if (d_in_do == 1'b1 && d_in_re == 1'b0 && d_in_mi == 1'b0)
    begin
        vol = 16'h5FFF;
        vol_minus = 16'hB000;
        note_div = 22'd191571;  
    end
    else if (d_in_do == 1'b0 && d_in_re == 1'b1 && d_in_mi == 1'b0)
    begin
        vol = 16'h5FFF;
        vol_minus = 16'hB000;
        note_div = 22'd170648;
    end
    else if (d_in_do == 1'b0 && d_in_re == 1'b0 && d_in_mi == 1'b1)
    begin
        vol = 16'h5FFF;
        vol_minus = 16'hB000;
        note_div = 22'd151515;
    end
    else
    begin
        vol = 16'h0000;
        vol_minus = 16'h0000;
        note_div = 22'd0;
    end

endmodule
