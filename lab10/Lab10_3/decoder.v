module decoder(
    digit,
    last_change,
    rst_n,
    clk
);
output [4:0] digit;
input [8:0] last_change;
input clk, rst_n;
reg [4:0] digit;
reg [4:0] digit_tmp;

always @*
    if (last_change[8] == 1'b0 && last_change[7:4] == 4'h1 && last_change[3:0] == 4'hC) //a
        digit_tmp = 5'd0;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'h2)    //b
        digit_tmp = 5'd1;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h2 && last_change[3:0] == 4'h1)    //c
        digit_tmp = 5'd2;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h2 && last_change[3:0] == 4'h3)    //d
        digit_tmp = 5'd3;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h2 && last_change[3:0] == 4'h4)    //e
        digit_tmp = 5'd4;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h2 && last_change[3:0] == 4'hB)    //f
        digit_tmp = 5'd5;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'h4)    //g
        digit_tmp = 5'd6;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'h3)    //h
        digit_tmp = 5'd7;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h4 && last_change[3:0] == 4'h3)    //i
        digit_tmp = 5'd8;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'hB)    //j
        digit_tmp = 5'd9;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h4 && last_change[3:0] == 4'h2)    //k
        digit_tmp = 5'd10;  
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h4 && last_change[3:0] == 4'hB)    //l
        digit_tmp = 5'd11;  
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'hA)    //m
        digit_tmp = 5'd12;  
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'h1)    //n
        digit_tmp = 5'd13; 
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h4 && last_change[3:0] == 4'h4)    //o
        digit_tmp = 5'd14;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h4 && last_change[3:0] == 4'hD)    //p
        digit_tmp = 5'd15;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h1 && last_change[3:0] == 4'h5)    //q
        digit_tmp = 5'd16;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h2 && last_change[3:0] == 4'hD)    //r
        digit_tmp = 5'd17;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h1 && last_change[3:0] == 4'hB)    //s
        digit_tmp = 5'd18;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h2 && last_change[3:0] == 4'hC)    //t
        digit_tmp = 5'd19;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'hC)    //u
        digit_tmp = 5'd20;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h2 && last_change[3:0] == 4'hA)    //v
        digit_tmp = 5'd21;
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h1 && last_change[3:0] == 4'hD)    //w
        digit_tmp = 5'd22; 
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h2 && last_change[3:0] == 4'h2)    //x
        digit_tmp = 5'd23;  
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h3 && last_change[3:0] == 4'h5)    //y
        digit_tmp = 5'd24;  
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h1 && last_change[3:0] == 4'hA)    //z
        digit_tmp = 5'd25;  
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h1 && last_change[3:0] == 4'h2 ||  //shift
            last_change[8] == 1'b0 && last_change[7:4] == 4'h5 && last_change[3:0] == 4'h9)
        digit_tmp = 5'd26; 
    else if (last_change[8] == 1'b0 && last_change[7:4] == 4'h5 && last_change[3:0] == 4'h8)    //Caps
        digit_tmp = 5'd27;
    else
        digit_tmp = digit;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        digit <= 5'b11111;
    else
        digit <= digit_tmp;

endmodule
