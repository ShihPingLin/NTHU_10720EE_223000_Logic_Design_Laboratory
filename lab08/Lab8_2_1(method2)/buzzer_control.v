`timescale 1ns / 1ps

module buzzer_control(
    clk,
    rst_n,
    vol,
    vol_minus,
    note_div,
    audio_left,
    audio_right
);
input clk;
input rst_n;
input [21:0] note_div;
input [15:0] vol, vol_minus;
output [15:0] audio_left;
output [15:0] audio_right;
reg [21:0] clk_cnt_next, clk_cnt;
reg b_clk, b_clk_next;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        clk_cnt <= 22'd0;
        b_clk <= 1'b0;
    end
    else
    begin
        clk_cnt <= clk_cnt_next;
        b_clk <= b_clk_next;
    end

always @*
    if (clk_cnt == note_div)
    begin
        clk_cnt_next = 22'd0;
        b_clk_next = ~b_clk;
    end
    else
    begin
        clk_cnt_next = clk_cnt + 1'b1;
        b_clk_next = b_clk;
    end

assign audio_left = (b_clk == 1'b0) ? vol_minus : vol;  //change the volume
assign audio_right = (b_clk == 1'b0) ? vol_minus : vol; //change the volume

endmodule
