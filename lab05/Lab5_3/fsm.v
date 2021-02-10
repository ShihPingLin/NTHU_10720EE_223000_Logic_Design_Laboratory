`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 18:29:14
// Design Name: 
// Module Name: fsm
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


module fsm(
    count_enable,   //count or not
    initial_100,
    initial_10,
    in,     //press or not
    in2,
    clk,    //global clock
    rst_n   //negative edge reset
);

output count_enable;
output [3:0] initial_100, initial_10;
input clk;
input rst_n;
input in, in2;
reg [3:0]initial_100, initial_10;
reg count_enable;
reg [1:0]state;
reg [1:0]state_2;
reg [1:0]next_state;
reg [1:0]next_state_2;

//FSM state decision
always @*
    case (state)
        2'b00:
        if (in == 1'b0)
            next_state = 2'b00;
        else
            next_state = 2'b01;
            
        2'b01:
        if (in == 1'b0)
            next_state = 2'b01;
        else
            next_state = 2'b00;
        
        2'b10:
            if (in == 1'b0)
                next_state = 2'b10;
            else
                next_state = 2'b01;
                
        default:    //only for format of case
            next_state = 2'b10;
    endcase

always @*
    case (state_2)
        2'b00:
        if (in2 == 1'b0)
            next_state_2 = 2'b00;
        else
            next_state_2 = 2'b01;
            
        2'b01:
        if (in2 == 1'b0)
            next_state_2 = 2'b01;
        else
            next_state_2 = 2'b00;
                
        default:    //only for format of case
            next_state_2 = 2'b00;
    endcase

always @*
    if (state == 2'b00)
        count_enable = 1;
    else if (state == 2'b01) 
        count_enable = 0;
    else
        count_enable = 0;

always @*
    if (state_2 == 2'b00) begin
        initial_100 = 4'd0;
        initial_10 = 4'd3;
    end
    else begin
        initial_100 = 4'd1;
        initial_10 = 4'd0;
    end

//FSM state transition
always @(posedge clk or negedge rst_n)
     if (~rst_n)
        state <= 2'b10;
     else begin
        state <= next_state;
        state_2 <= next_state_2;
     end

endmodule