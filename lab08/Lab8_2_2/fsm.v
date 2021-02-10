`timescale 1ns / 1ps

module fsm(
    note_div,
    vol,
    vol_minus,
    state,
    in_up_pulse,
    in_down_pulse,
    clk,    //global clock
    rst_n   //negative edge reset
);
output [21:0] note_div;
output [15:0] vol, vol_minus;
output [4:0] state;
input in_up_pulse, in_down_pulse;
input clk, rst_n;
reg [21:0] note_div;
reg [15:0] vol, vol_minus;
reg [4:0] state;
reg [4:0] next_state;

//FSM state decision
always @*
    case (state)
        5'd0:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd1;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd0;
            else
                next_state = 5'd0;
 
         5'd1:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd2;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd0;
            else
                next_state = 5'd1;

         5'd2:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd3;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd1;
            else
                next_state = 5'd2;

         5'd3:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd4;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd2;
            else
                next_state = 5'd3;   

        5'd4:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd5;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd3;
            else
                next_state = 5'd4;
 
         5'd5:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd6;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd4;
            else
                next_state = 5'd5;

         5'd6:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd7;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd5;
            else
                next_state = 5'd6;

         5'd7:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd8;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd6;
            else
                next_state = 5'd7;   

        5'd8:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd9;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd7;
            else
                next_state = 5'd8;
 
         5'd9:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd10;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd8;
            else
                next_state = 5'd9;

         5'd10:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd11;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd9;
            else
                next_state = 5'd10;

         5'd11:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd12;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd10;
            else
                next_state = 5'd11;

         5'd12:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd13;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd11;
            else
                next_state = 5'd12;   

        5'd13:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd14;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd12;
            else
                next_state = 5'd13;
 
         5'd14:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd15;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd13;
            else
                next_state = 5'd14;

         5'd15:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd16;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd14;
            else
                next_state = 5'd15;

         5'd16:  
            if (in_up_pulse == 1'b1 && in_down_pulse == 1'b0)
                next_state = 5'd16;
            else if (in_up_pulse == 1'b0 && in_down_pulse == 1'b1)
                next_state = 5'd15;
            else
                next_state = 5'd16;  
                        
          default:    //default state
                next_state = 5'd0;
    endcase

//FSM state ouput
always @*
    if (state == 5'd0)
    begin
        vol = 16'h0000;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd1)
    begin
        vol = 16'h00FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd2)
    begin
        vol = 16'h02FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd3)
    begin
        vol = 16'h04FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd4)
    begin
        vol = 16'h08FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd5)
    begin
        vol = 16'h0CFF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd6)
    begin
        vol = 16'h0FFF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd7)
    begin
        vol = 16'h14FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd8)
    begin
        vol = 16'h18FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd9)
    begin
        vol = 16'h1CFF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd10)
    begin
        vol = 16'h1FFF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd11)
    begin
        vol = 16'h24FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd12)
    begin
        vol = 16'h28FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd13)
    begin
        vol = 16'h2CFF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd14)
    begin
        vol = 16'h2FFF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else if (state == 5'd15)
    begin
        vol = 16'h34FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
    else              
    begin
        vol = 16'h38FF;
        vol_minus = 16'h0000;
        note_div = 22'd191571;
    end
        
//FSM state transition
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 5'd0;
    else
        state <= next_state;

endmodule