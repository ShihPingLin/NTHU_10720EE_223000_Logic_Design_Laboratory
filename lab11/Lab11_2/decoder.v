module decoder(
    digit,
    last_change,
    rst_n,
    clk
);
output [3:0] digit;
input [8:0] last_change;
input clk, rst_n;
reg [3:0] digit;
reg [3:0] digit_tmp;

always @*
    if (last_change[8] == 1'b0 && last_change[7:4] == 4'h7 && last_change[3:0] == 4'h0)
        digit_tmp = 4'd0;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h6 && last_change[3:0] == 4'h9)
        digit_tmp = 4'd1;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h7 && last_change[3:0] == 4'h2)
        digit_tmp = 4'd2;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h7 && last_change[3:0] == 4'hA)
        digit_tmp = 4'd3;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h6 && last_change[3:0] == 4'hB)
        digit_tmp = 4'd4;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h7 && last_change[3:0] == 4'h3)
        digit_tmp = 4'd5;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h7 && last_change[3:0] == 4'h4)
        digit_tmp = 4'd6;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h6 && last_change[3:0] == 4'hC)
        digit_tmp = 4'd7;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h7 && last_change[3:0] == 4'h5)
        digit_tmp = 4'd8;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h7 && last_change[3:0] == 4'hD)
        digit_tmp = 4'd9;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h1 && last_change[3:0] == 4'hC)
        digit_tmp = 4'd10;  //addition
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h1 && last_change[3:0] == 4'hB)
        digit_tmp = 4'd11;  //subtraction
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'hA)
        digit_tmp = 4'd12;  //multiplication
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h5 && last_change[3:0] == 4'h5)
        digit_tmp = 4'd14;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h5 && last_change[3:0] == 4'hA)
        digit_tmp = 4'd15;  //enter
    else
        digit_tmp = digit;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        digit <= 4'b1111;
    else
        digit <= digit_tmp;

endmodule