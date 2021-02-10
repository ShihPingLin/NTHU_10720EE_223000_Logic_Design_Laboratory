`timescale 1ns / 1ps

module fsm(
    note_div,
    vol,
    vol_minus,
    state,
    in_do_pulse,
    in_re_pulse,
    in_mi_pulse,
    clk,    //global clock
    rst_n   //negative edge reset
);
output [21:0] note_div;
output [15:0] vol, vol_minus;
output [1:0] state;
input in_do_pulse, in_re_pulse, in_mi_pulse;
input clk, rst_n;
reg [21:0] note_div;
reg [15:0] vol, vol_minus;
reg [1:0] state;
reg [1:0] next_state;

//FSM state decision
always @*
    case (state)
        2'b00:  //reset state
        if (in_do_pulse == 1'b1 && in_re_pulse == 1'b0 && in_mi_pulse == 1'b0)
            next_state = 2'b01;
        else if (in_do_pulse == 1'b0 && in_re_pulse == 1'b1 && in_mi_pulse == 1'b0)
            next_state = 2'b10;
        else if (in_do_pulse == 1'b0 && in_re_pulse == 1'b0 && in_mi_pulse == 1'b1)
            next_state = 2'b11;
        else
            next_state = 2'b00;
            
        2'b01:   //Do state
        if (in_do_pulse == 1'b0 && in_re_pulse == 1'b1 && in_mi_pulse == 1'b0)
            next_state = 2'b10;
        else if (in_do_pulse == 1'b0 && in_re_pulse == 1'b0 && in_mi_pulse == 1'b1)
            next_state = 2'b11;
        else
            next_state = 2'b01;
        
        2'b10:  //Re state
        if (in_do_pulse == 1'b1 && in_re_pulse == 1'b0 && in_mi_pulse == 1'b0)
            next_state = 2'b01;
        else if (in_do_pulse == 1'b0 && in_re_pulse == 1'b0 && in_mi_pulse == 1'b1)
            next_state = 2'b11;
        else
            next_state = 2'b10;
        
        2'b11:  //Mi state
        if (in_do_pulse == 1'b1 && in_re_pulse == 1'b0 && in_mi_pulse == 1'b0)
            next_state = 2'b01;
        else if (in_do_pulse == 1'b0 && in_re_pulse == 1'b1 && in_mi_pulse == 1'b0)
            next_state = 2'b10;
        else
            next_state = 2'b11;
        
        default:    //default state
            next_state = 2'b00;
    endcase

//FSM state ouput
always @*
    if (state == 2'b00) //reset state
    begin
        vol = 16'h0000;
        vol_minus = 16'h0000;
        note_div = 22'd0;
    end
    else if (state == 2'b01)    //Do state
    begin
        vol = 16'h5FFF;
        vol_minus = 16'hB000;
        note_div = 22'd191571;
    end
    else if (state == 2'b10)    //Re state
    begin
        vol = 16'h5FFF;
        vol_minus = 16'hB000;
        note_div = 22'd170648;
    end
    else                        //Mi state
    begin
        vol = 16'h5FFF;
        vol_minus = 16'hB000;
        note_div = 22'd151515;
    end
        
//FSM state transition
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 2'b0;
    else
        state <= next_state;

endmodule