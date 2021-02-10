`timescale 1ns / 1ps

module fsm(
    state,  //for debug
    count_enable,
    lap,
    rst_state,
    start_pulse,
    lap_pulse,
    rst,
    clk,
    rst_n
);
output [1:0] state;   //for debug
output count_enable, lap, rst_state;
input start_pulse, lap_pulse, rst;
input clk, rst_n;
reg count_enable, lap, rst_state;
reg [1:0] state;
reg [1:0] next_state;

//FSM state decision
always @*
    case (state)
        //pause state
        2'b00:
        if (start_pulse == 1'b1 && lap_pulse == 1'b0 && rst == 1'b0)
            next_state = 2'b01;
        else if (start_pulse == 1'b0 && lap_pulse == 1'b0 && rst == 1'b1)
            next_state = 2'b11;
        else
            next_state = 2'b00;

        //start state
        2'b01:
        if (start_pulse == 1'b1 && lap_pulse == 1'b0 && rst == 1'b0)
            next_state = 2'b00;
        else if (start_pulse == 1'b0 && lap_pulse == 1'b1 && rst == 1'b0)
            next_state = 2'b10;
        else if (start_pulse == 1'b0 && lap_pulse == 1'b0 && rst == 1'b1)
            next_state = 2'b11;
        else
            next_state = 2'b01;

        //lap state
        2'b10:
        if (start_pulse == 1'b0 && lap_pulse == 1'b1 && rst == 1'b0)
            next_state = 2'b01;
        else if(start_pulse == 1'b0 && lap_pulse == 1'b0 && rst == 1'b1)
            next_state = 2'b11;
        else
            next_state = 2'b10;
        
        //reset state
        2'b11:
        if (start_pulse == 1'b1 && lap_pulse == 1'b0 && rst == 1'b0)
            next_state = 2'b01;
        else
            next_state = 2'b11;
            
        default:    //only for format of case
            next_state = 2'b11;    
    endcase

always @*
    //pause state
    if (state == 2'b00) begin
        count_enable = 1'b0;
        lap = 1'b0;
        rst_state = 1'b0;
    end
    //start state
    else if (state == 2'b01) begin
        count_enable = 1'b1;
        lap = 1'b0;
        rst_state = 1'b0;
    end
    //lap state
    else if (state == 2'b10) begin
        count_enable = 1'b1;
        lap = 1'b1;
        rst_state = 1'b0;
    end 
    //reset state
    else begin
        count_enable = 1'b0;
        lap = 1'b0;
        rst_state = 1'b1;
    end

//FSM state transition
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 2'b11;
    else
        state <= next_state;

endmodule