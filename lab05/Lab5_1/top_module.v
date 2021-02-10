`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/15 13:14:34
// Design Name: 
// Module Name: top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module from_bincnt_to_display(
    segs,   //7-segment display
    ssd_ctl,    //scan control
    LED_control,
    clk,    //clock from oscillator
    rst_n,   //active low reset
    count_enable
);
output [7:0] segs;
output [3:0] ssd_ctl;
output [15:0] LED_control;
input clk;
input rst_n;
input count_enable;
wire clk_out;
wire [1:0] ssd_ctl_en;
wire [3:0] digit0, digit1;
wire [3:0] ssd_in;

//Frequency_divider
clock_generator U0(
    .clk(clk),    //clock from crystal
    .rst_n(rst_n),  //active low reset
    .clk_1(clk_out),  //generated 1Hz clock
    .clk_100(), //generated 100Hz clock
    .clk_ctl(ssd_ctl_en) //scan control
);

//two_digit_binary_down_counter
two_digit_bincnt U1(
    .digit0(digit0), //digit in one
    .digit1(digit1), //digit in ten
    .LED_control(LED_control),
    .clk(clk_out),
    .rst_n(rst_n),   //negative edge reset
    .en(count_enable)
);

//Scan_control
scan_ctl U2(
    .ssd_ctl(ssd_ctl),    //ssd display control signal
    .ssd_in(ssd_in),     //output to ssd display
    .in0(4'b1111),        //1st input
    .in1(4'b1111),        //2nd input
    .in2(digit1),        //3rd input
    .in3(digit0),        //4th input
    .ssd_ctl_en(ssd_ctl_en)  //divided clock for scan control
);

//display
display U3(
    .D_ssd(segs),  //seven_segment output
    .i(ssd_in)       //input counter value
);
endmodule
