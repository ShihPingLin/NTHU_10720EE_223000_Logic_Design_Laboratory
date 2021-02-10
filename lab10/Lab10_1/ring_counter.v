module ring_counter(
    note_div,
    clk,
    rst_n
);
output [21:0] note_div;
input clk, rst_n;
reg [21:0] note_div;
reg [4:0] count, count_tmp;

always @*
     if (count == 5'd0)
        note_div = 22'd1;
     else if (count == 5'd1)
        note_div = 22'd227272;  //Low La
     else if (count == 5'd2)
        note_div = 22'd204081;  //Low Si
     else if (count == 5'd3)
        note_div = 22'd191571;  //Mid Do
     else if (count == 5'd4)
        note_div = 22'd170648;  //Mid Re
     else if (count == 5'd5)
        note_div = 22'd151515;  //Mid Mi
     else if (count == 5'd6)
        note_div = 22'd143266;  //Mid Fa
     else if (count == 5'd7)
        note_div = 22'd127551;  //Mid So
     else if (count == 5'd8)
        note_div = 22'd113636;  //Mid La
     else if (count == 5'd9)
        note_div = 22'd101215;  //Mid Si
     else if (count == 5'd10)
        note_div = 22'd95420;   //High Do
     else if (count == 5'd11)
        note_div = 22'd85034;   //High Re
     else if (count == 5'd12)
        note_div = 22'd75758;   //High Mi
     else if (count == 5'd13)
        note_div = 22'd71633;   //High Fa
     else if (count == 5'd14)
        note_div = 22'd63775;   //High So
     else if (count == 5'd15)
        note_div = 22'd56818;   //High La
     else
        note_div = 22'd50607;   //High Si

always @*
    if (count == 5'd16)
        count_tmp = 5'd1;
    else
        count_tmp = count + 1'b1;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        count <= 5'd0;
    else
        count <= count_tmp;

endmodule
