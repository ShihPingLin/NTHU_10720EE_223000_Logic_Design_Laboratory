`timescale 1ns / 1ps

module frequency_divider(    
    clk_mclk,       //generated 25MHz clock
    clk_lrck,       //generated 25MHz/128 clock
    clk_sck,        //generated 25MHz/4 clock
    clk,            //clock from crystal
    rst_n           //active low reset
);
output clk_mclk;
output clk_lrck;
output clk_sck;
input clk;
input rst_n;
reg clk_mclk;
reg clk_lrck;
reg clk_sck;

reg [26:0] count_mclk, count_mclk_next;
reg [26:0] count_lrck, count_lrck_next;
reg [26:0] count_sck, count_sck_next;
reg clk_mclk_next;
reg clk_lrck_next;
reg clk_sck_next;

always @*
    if (count_mclk == 27'd1)    //generated 25MHz clock
    begin
        count_mclk_next = 27'd0;
        clk_mclk_next = ~clk_mclk;
    end
    else
    begin
        count_mclk_next = count_mclk + 27'd1;
        clk_mclk_next = clk_mclk;
    end
 
always @*
    if (count_lrck == 27'd255)   //generated 25MHz / 128 clock
    begin
        count_lrck_next = 27'd0;
        clk_lrck_next = ~clk_lrck;
    end
    else
    begin
        count_lrck_next = count_lrck + 1'b1;
        clk_lrck_next = clk_lrck;
    end

always @*
    if (count_sck == 27'd7)   //generated 25MHz / 4 clock
    begin
        count_sck_next = 27'd0;
        clk_sck_next = ~clk_sck;
    end
    else
    begin
        count_sck_next = count_sck + 1'b1;
        clk_sck_next = clk_sck;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        count_mclk <= 27'd0;
        clk_mclk <= 1'b0;        
        
        count_lrck <= 27'd0;
        clk_lrck <= 1'b0;        
        
        count_sck <= 27'd0;
        clk_sck <= 1'b0;   
    end
    else
    begin
        count_mclk <= count_mclk_next;
        clk_mclk <= clk_mclk_next;       
        
        count_lrck <= count_lrck_next;
        clk_lrck <= clk_lrck_next;          
        
        count_sck <= count_sck_next;
        clk_sck <= clk_sck_next;  
    end
endmodule