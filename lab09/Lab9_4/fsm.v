module fsm(
    state,
    capital,
    digit,
    key_down,
    clk,
    rst_n
);
output [1:0] state;
output capital;
input [4:0] digit;
input [511:0] key_down;
input clk, rst_n;
reg [1:0] state, next_state;
reg capital;

always @*
    if (state == 2'd0) begin    //lower case state
        if (digit == 5'd27 && key_down != 512'b0)
            next_state = 2'd1;
        else
            next_state = 2'd0;
    end
    else if (state == 2'd1) begin   //buffer state
        if (key_down == 512'b0)
            next_state = 2'd2;
        else
            next_state = 2'd1;
    end
    else if (state == 2'd2) begin
        if (digit == 5'd27 && key_down != 512'b0)
            next_state = 2'd3;
        else
            next_state = 2'd2;        
    end
    else if (state == 2'd3) begin   //buffer state
        if (key_down == 512'b0)
            next_state = 2'd0;
        else
            next_state = 2'd3;
    end
    else    //default state
        next_state = 2'd0;

always @*
    if (state == 2'd0)
        capital = 1'b0;
    else if (state == 2'd1)
        capital = 1'b1;
    else if (state == 2'd2)
        capital = 1'b1;
    else
        capital = 1'b0;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 2'd0;
    else
        state <= next_state;

endmodule
