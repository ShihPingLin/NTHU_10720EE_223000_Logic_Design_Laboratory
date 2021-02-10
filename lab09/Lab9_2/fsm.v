module fsm(
    digit3,
    digit2,
    digit1,
    digit0,
    digit,
    clk,
    rst_n
);
output [3:0] digit0, digit1, digit2, digit3;
input [3:0] digit;
input clk, rst_n;
reg [3:0] digit0, digit1, digit2, digit3;
reg [3:0] digit0_tmp, digit1_tmp, digit2_tmp, digit3_tmp;
reg [2:0] state, next_state;

always @*
    if (state == 3'd0) begin
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            next_state = 3'd1;
        else
            next_state = 3'd0;
    end
    else if (state == 3'd1) begin
        if (digit == 4'd10)
            next_state = 3'd2;
        else
            next_state = 3'd1;
    end
    else if (state == 3'd2) begin
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            next_state = 3'd3;
        else
            next_state = 3'd2;        
    end
    else if (state == 3'd3) begin
        if (digit == 4'd15)
            next_state = 3'd4;
        else
            next_state = 3'd3;
    end
    else if (state == 3'd4) begin
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            next_state = 3'd1;
        else
            next_state = 3'd4;        
    end
    else    //default state
        next_state = 3'd0;

always @*
    if (state == 3'd0) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = 4'b1111;
        digit2_tmp = 4'b1111;
        digit3_tmp = 4'b1111;
    end
    else if (state == 3'd1) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = 4'b1111;
        digit2_tmp = 4'b1111;
        
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            digit3_tmp = digit;
        else
            digit3_tmp = digit3;
    end
    else if (state == 3'd2) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = 4'b1111;
        digit2_tmp = 4'b1111;
        digit3_tmp = digit3;        
    end
    else if (state == 3'd3) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = 4'b1111;
    
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            digit2_tmp = digit;
        else
            digit2_tmp = digit2;
        
        digit3_tmp = digit3;        
    end
    else begin  //state4
        digit0_tmp = (digit2 + digit3) % 10;
        digit1_tmp = (digit2 + digit3) / 10;
        digit2_tmp = digit2;
        digit3_tmp = digit3;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n) begin
        state <= 3'd0;
        digit0 <= 4'b1111;
        digit1 <= 4'b1111;
        digit2 <= 4'b1111;
        digit3 <= 4'b1111;
    end
    else begin
        state <= next_state;
        digit0 <= digit0_tmp;
        digit1 <= digit1_tmp;
        digit2 <= digit2_tmp;
        digit3 <= digit3_tmp;
    end

endmodule
