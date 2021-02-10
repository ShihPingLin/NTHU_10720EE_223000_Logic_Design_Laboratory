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
    in,     //press or not
    clk,    //global clock
    rst_n   //negative edge reset
);

output count_enable;
input clk;
input rst_n;
input in;
reg count_enable;
reg state;
reg next_state;

//FSM state decision
always @*
    case (state)
        1'b0:
        if (in)
        begin
            next_state = 1'b1;
//           count_enable = 1'b1;
        end
        else
        begin
            next_state = 1'b0;
//           count_enable = 1'b0;
        end
        1'b1:
        if (in)
        begin
            next_state = 1'b0;
//           count_enable = 1'b0;
        end
        else
        begin
            next_state = 1'b1;
//           count_enable = 1'b1;
        end
        default:    //only for format of case
        begin
            next_state = 1'b0;
//            count_enable = 1'b0;
        end
    endcase

always @*
    if (state == 0)
        count_enable = 1'b0;
    else
        count_enable = 1'b1;

//FSM state transition
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 1'b0;
    else
        state <= next_state;

endmodule