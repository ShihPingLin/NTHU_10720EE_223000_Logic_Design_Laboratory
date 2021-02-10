`timescale 1ns / 1ps

module MUX(
    LED_control,
    digit0,
    digit1,
    digit2,
    digit3,
    mode,
    digit0_timer,
    digit1_timer,
    digit2_timer,
    digit3_timer,
    digit0_stop,
    digit1_stop,
    digit2_stop,
    digit3_stop,
    LED_control_tmp  
);
output [15:0] LED_control;
output [3:0] digit0, digit1, digit2, digit3;
input mode;
input [3:0] digit0_stop, digit1_stop, digit2_stop, digit3_stop;
input [3:0] digit0_timer, digit1_timer, digit2_timer, digit3_timer;
input [15:0] LED_control_tmp;
reg [15:0] LED_control;
reg [3:0] digit0, digit1, digit2, digit3;

always @*
    if (mode == 1'b0) begin   //stop_watch mode
        digit0 = digit0_stop;
        digit1 = digit1_stop;
        digit2 = digit2_stop;
        digit3 = digit3_stop;
        LED_control = 15'd0;
    end
    else begin  //timer mode
        digit0 = digit0_timer;
        digit1 = digit1_timer;
        digit2 = digit2_timer;
        digit3 = digit3_timer;
        LED_control = LED_control_tmp;
    end

endmodule
