module fsm(
    enable,
    en_pulse,
    clk,
    rst_n
);
output enable;
input en_pulse, clk, rst_n;
reg enable;
reg state, state_tmp;

always @*
    case (state)
        1'b0:
        if (en_pulse)
            state_tmp = 1'b1;
        else 
            state_tmp = state;
        1'b1:
        if (en_pulse)
            state_tmp = 1'b0;
        else
            state_tmp = state;
            
        default:
            state_tmp = 1'b0;
    endcase

always @*
    if (state == 1'b0)
        enable = 1'b0;
    else if (state == 1'b1)
        enable = 1'b1;
    else
        enable = 1'b0;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 1'b0;
    else
        state <= state_tmp;

endmodule
