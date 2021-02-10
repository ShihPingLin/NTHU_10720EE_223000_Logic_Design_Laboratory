`timescale 1ns / 1ps

module fsm(
    state,  //for debug
    count_enable,
    stop,
    start_pulse,
    pause_pulse,
    setting,
    clk,
    rst_n
);
output [1:0] state;   //for debug
output count_enable, stop;
input start_pulse, pause_pulse, setting;
input clk, rst_n;
reg count_enable, stop, rst_state;
reg [1:0] state;
reg [1:0] next_state;

//FSM state decision
always @*
    case (state)
        //stop(reset) state
        2'b00:
        if (setting == 1'b1)
            next_state = 2'b00;
        else if (start_pulse == 1'b1 && pause_pulse == 1'b0 && setting == 1'b0)
            next_state = 2'b01;
        else
            next_state = 2'b00;

        //start state
        2'b01:
        if (setting == 1'b1)
            next_state = 2'b00;
        else if (start_pulse == 1'b1 && pause_pulse == 1'b0 && setting == 1'b0)
            next_state = 2'b00;
        else if (start_pulse == 1'b0 && pause_pulse == 1'b1 && setting == 1'b0)
            next_state = 2'b10;
        else
            next_state = 2'b01;

        //pause state
        2'b10:
        if (setting == 1'b1)
            next_state = 2'b00;
        else if (start_pulse == 1'b0 && pause_pulse == 1'b1 && setting == 1'b0)
            next_state = 2'b01;
        else if(start_pulse == 1'b1 && pause_pulse == 1'b0 && setting == 1'b0)
            next_state = 2'b00;
        else
            next_state = 2'b10;
        
        default:    //only for format of case
            next_state = 2'b00;
                
    endcase

always @*
    //stop(reset) state
    if (state == 2'b00) begin
        count_enable = 1'b0;
        stop = 1'b1;
    end
    //start state
    else if (state == 2'b01) begin
        count_enable = 1'b1;
        stop = 1'b0;
    end
    //pause state
    else begin
        count_enable = 1'b0;
        stop = 1'b0;
    end 

//FSM state transition
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 2'b00;
    else
        state <= next_state;

endmodule