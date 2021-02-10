module fsm(
    digit3,
    digit2,
    digit1,
    digit0,
    state,
    operator,
    digit,
    key_down,
    clk,
    rst_n
);
output [3:0] digit0, digit1, digit2, digit3;
output [3:0] state;
output [3:0] operator;
input [511:0] key_down;
input [3:0] digit;
input clk, rst_n;
reg [3:0] digit0, digit1, digit2, digit3;
reg [3:0] digit0_tmp, digit1_tmp, digit2_tmp, digit3_tmp;
reg [3:0] operator, operator_tmp;
reg [15:0] val_cal, val_cal2, val, val2;
reg [3:0] state, next_state;

always @*
    if (state == 4'd0) begin
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            next_state = 4'd1;
        else
            next_state = 4'd0;
    end
    else if (state == 4'd1) begin
        if (digit == 4'd15)
            next_state = 4'd2;
        else
            next_state = 4'd1;
    end
    else if (state == 4'd2) begin
        if (digit == 4'd10 || digit == 4'd11 || digit == 4'd12)
            next_state = 4'd3;
        else
            next_state = 4'd2;
    end
    else if (state == 4'd3) begin
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            next_state = 4'd4;
        else
            next_state = 4'd3;        
    end
    else if (state == 4'd4) begin
        if (digit == 4'd15)
            next_state = 4'd5;
        else
            next_state = 4'd4;
    end
    else if (state == 4'd5) begin
        if (key_down == 512'd0)
            next_state = 4'd6;
        else
            next_state = 4'd5;
    end
    else if (state == 4'd6) begin
        if (digit == 4'd15 && key_down != 512'd0)
            next_state = 4'd7;
        else
            next_state = 4'd6; 
    end
    else if (state == 4'd7) begin
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            next_state = 4'd1;
        else
            next_state = 4'd7;        
    end
    else    //default state
        next_state = 4'd0;

always @*
    if (state == 4'd0) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = 4'b1111;
        digit2_tmp = 4'b1111;
        digit3_tmp = 4'b1111;
        operator_tmp = 4'd10;
    end
    else if (state == 4'd1) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = 4'b1111;
        digit2_tmp = 4'b1111;
        
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            digit3_tmp = digit;
        else
            digit3_tmp = digit3;
        
        operator_tmp = 4'd10;
    end
    else if (state == 4'd2) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = 4'b1111;
     
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            digit2_tmp = digit;
        else
            digit2_tmp = digit2;
        
        digit3_tmp = digit3;
        operator_tmp = 4'd10;
    end
    else if (state == 4'd3) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = 4'b1111;
        digit2_tmp = digit2;
        digit3_tmp = digit3;
        val = digit3 * 10 + digit2; 
        
        if (digit == 4'd10 || digit == 4'd11 || digit == 4'd12)
            operator_tmp = digit;
        else
            operator_tmp = operator;        
    end
    else if (state == 4'd4) begin
        digit0_tmp = 4'b1111;
    
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            digit1_tmp = digit;
        else
            digit1_tmp = digit1;
        
        digit2_tmp = digit2;
        digit3_tmp = digit3;
        operator_tmp = operator;        
    end
    else if (state == 4'd5) begin
        digit0_tmp = 4'b1111;
        digit1_tmp = digit1;
        digit2_tmp = digit2;
        digit3_tmp = digit3;
        operator_tmp = operator;
    end
    else if (state == 4'd6) begin
        if (digit == 4'd0 || digit == 4'd1 || digit == 4'd2 || digit == 4'd3 || digit == 4'd4
        || digit == 4'd5 || digit == 4'd6 || digit == 4'd7 || digit == 4'd8 || digit == 4'd9)
            digit0_tmp = digit;
        else
            digit0_tmp = digit0;
        
        digit1_tmp = digit1;
        digit2_tmp = digit2;
        digit3_tmp = digit3;
        val2 = digit1 * 10 + digit0;
        operator_tmp = operator;        
    end
    else begin           
        if (operator == 4'd10) begin //addition
            digit3_tmp = 4'b1111;
            
            if (val + val2 >= 100) begin
                digit2_tmp = (val + val2) / 100;
                val_cal = (val + val2) % 100;
                digit1_tmp = val_cal / 10;
                digit0_tmp = val_cal % 10;
            end
            else if (val + val2 < 100 && val + val2 >= 10) begin
                digit2_tmp = 4'b1111;
                digit1_tmp = (val + val2) / 10;
                digit0_tmp = (val + val2) % 10;
            end
            else begin
                digit2_tmp = 4'b1111;
                digit1_tmp = 4'b1111;
                digit0_tmp = val + val2;
            end
        end
        else if (operator == 4'd11) begin //subtraction
            digit3_tmp = 4'b1111;
            
            if (val >= val2) begin
                digit2_tmp = 4'b1111;
                
                if (val - val2 >= 10) begin 
                    digit1_tmp = (val - val2) / 10;
                    digit0_tmp = (val - val2) % 10;
                end
               else begin
                    digit1_tmp = 4'b1111;
                    digit0_tmp = val - val2;
               end
            end
            else begin
                if (val2 - val >= 10) begin
                    digit2_tmp = 4'd11;
                    digit1_tmp = (val2 - val) / 10;
                    digit0_tmp = (val2 - val) % 10;
                end
                else begin
                    digit2_tmp = 4'b1111;
                    digit1_tmp = 4'd11;
                    digit0_tmp = val2 - val;;
                end
            end
        end
        else begin   //multiplication
            if (val * val2 >= 1000) begin
                digit3_tmp = (val * val2) / 1000;
                val_cal = (val * val2) % 1000;
                digit2_tmp = val_cal / 100;
                val_cal2 = val_cal % 100;
                digit1_tmp = val_cal2 / 10;
                digit0_tmp = val_cal2 % 10;
            end
            else if (val * val2 < 1000 && val * val2 >= 100) begin
                digit3_tmp = 4'b1111;
                digit2_tmp = (val * val2) / 100;
                val_cal = (val * val2) % 100;
                digit1_tmp = val_cal / 10;
                digit0_tmp = val_cal % 10;
            end
            else if (val * val2 < 100 && val * val2 >= 10) begin
                digit3_tmp = 4'b1111;
                digit2_tmp = 4'b1111;
                digit1_tmp = (val * val2) / 10;
                digit0_tmp = (val * val2) % 10;
            end
            else begin
                digit3_tmp = 4'b1111;
                digit2_tmp = 4'b1111;
                digit1_tmp = 4'b1111;
                digit0_tmp = val * val2;
            end
        end
        
        operator_tmp = operator;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n) begin
        state <= 4'd0;
        digit0 <= 4'b1111;
        digit1 <= 4'b1111;
        digit2 <= 4'b1111;
        digit3 <= 4'b1111;
        operator <= 4'd10;
    end
    else begin
        state <= next_state;
        digit0 <= digit0_tmp;
        digit1 <= digit1_tmp;
        digit2 <= digit2_tmp;
        digit3 <= digit3_tmp;
        operator <= operator_tmp;
    end

endmodule