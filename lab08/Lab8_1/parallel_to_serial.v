`timescale 1ns / 1ps

module parallel_to_serial(
    audio_stdin,
    audio_left,
    audio_right,
    clk,
    rst_n
);
output audio_stdin;
input [15:0] audio_left, audio_right;
input clk, rst_n;
reg audio_stdin;
reg [4:0] value, value_tmp;

always @*
    if (value_tmp == 5'd1)
        audio_stdin = audio_right[0];
    else if (value_tmp == 5'd2)
        audio_stdin = audio_left[15];
    else if (value_tmp == 5'd3)
        audio_stdin = audio_left[14];
    else if (value_tmp == 5'd4)
        audio_stdin = audio_left[13];
    else if (value_tmp == 5'd5)
        audio_stdin = audio_left[12];        
    else if (value_tmp == 5'd6)
        audio_stdin = audio_left[11];
    else if (value_tmp == 5'd7)
        audio_stdin = audio_left[10];        
    else if (value_tmp == 5'd8)
        audio_stdin = audio_left[9];
    else if (value_tmp == 5'd9)
        audio_stdin = audio_left[8];
    else if (value_tmp == 5'd10)
        audio_stdin = audio_left[7];
    else if (value_tmp == 5'd11)
        audio_stdin = audio_left[6];        
    else if (value_tmp == 5'd12)
        audio_stdin = audio_left[5];
    else if (value_tmp == 5'd13)
        audio_stdin = audio_left[4]; 
    else if (value_tmp == 5'd14)
        audio_stdin = audio_left[3];
    else if (value_tmp == 5'd15)
        audio_stdin = audio_left[2]; 
    else if (value_tmp == 5'd16)
        audio_stdin = audio_left[1];
    else if (value_tmp == 5'd17)
        audio_stdin = audio_left[0];
    else if (value_tmp == 5'd18)
        audio_stdin = audio_right[15];
    else if (value_tmp == 5'd19)
        audio_stdin = audio_right[14];
    else if (value_tmp == 5'd20)
        audio_stdin = audio_right[13];        
    else if (value_tmp == 5'd21)
        audio_stdin = audio_right[12];
    else if (value_tmp == 5'd22)
        audio_stdin = audio_right[11];        
    else if (value_tmp == 5'd23)
        audio_stdin = audio_right[10];
    else if (value_tmp == 5'd24)
        audio_stdin = audio_right[9];
    else if (value_tmp == 5'd25)
        audio_stdin = audio_right[8];
    else if (value_tmp == 5'd26)
        audio_stdin = audio_right[7];        
    else if (value_tmp == 5'd27)
        audio_stdin = audio_right[6];
    else if (value_tmp == 5'd28)
        audio_stdin = audio_right[5]; 
    else if (value_tmp == 5'd29)
        audio_stdin = audio_right[4];
    else if (value_tmp == 5'd30)
        audio_stdin = audio_right[3]; 
    else if (value_tmp == 5'd31)
        audio_stdin = audio_right[2];
    else
        audio_stdin = audio_right[1]; 

always @*
    value_tmp = value + 5'd1;

always @(negedge clk or negedge rst_n)
    if (~rst_n)
        value <= 5'd0;
    else
        value <= value_tmp;

endmodule
