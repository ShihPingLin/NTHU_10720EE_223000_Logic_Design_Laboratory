`timescale 1ns / 1ps

module fsm(
    mode,
    count_enable_2,
    stop,
    setting,
    count_enable,
    lap,
    rst_state,
    in1_pulse,
    in2_pulse,
    in2_long_pulse,
    mode_pulse,
    clk,
    rst_n
);
output mode;
output count_enable_2, stop, setting;
output count_enable, lap, rst_state;
input in1_pulse, in2_pulse, in2_long_pulse, mode_pulse;
input clk, rst_n;
reg [2:0] state;
reg [2:0] next_state;
reg mode;
reg count_enable_2, stop, setting;
reg count_enable, lap, rst_state;

//FSM state decision
always @*
    case (state)
        //stop_watch_mode(reset state)
        3'b000:
        if (in1_pulse == 1'b1 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b001;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b1)
            next_state = 3'b100;
        else
            next_state = 3'b000;

        //stop_watch_mode(start state)
        3'b001:
        if (in1_pulse == 1'b1 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b010;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b1 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b011;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b1 && mode_pulse == 1'b0)
            next_state = 3'b000;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b1)
            next_state = 3'b100;
        else
            next_state = 3'b001;

        //stop_watch_mode(pause state)
        3'b010:
        if (in1_pulse == 1'b1 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b001;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b1 && mode_pulse == 1'b0)
            next_state = 3'b000;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b1)
            next_state = 3'b100;
        else
            next_state = 3'b010;
        
        //stop_watch_mode(lap state)
        3'b011:
        if (in1_pulse == 1'b0 && in2_pulse == 1'b1 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b001;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b1 && mode_pulse == 1'b0)
            next_state = 3'b000;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b1)
            next_state = 3'b100;
        else
            next_state = 3'b011;
            
        //timer_mode(stop state)
        3'b100:
        if (in1_pulse == 1'b1 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b101;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b1 && mode_pulse == 1'b0)
            next_state = 3'b111;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b1)
            next_state = 3'b000;
        else
            next_state = 3'b100;    

        //timer_mode(start state)                
        3'b101:
        if (in1_pulse == 1'b1 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b100;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b1 && mode_pulse == 1'b0)
            next_state = 3'b111;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b1)
            next_state = 3'b000;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b1 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b110;
        else
            next_state = 3'b101;    
            
        //timer_mode(pause state)
        3'b110:
        if (in1_pulse == 1'b0 && in2_pulse == 1'b1 && in2_long_pulse == 1'b0 && mode_pulse == 1'b0)
            next_state = 3'b101;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b1 && mode_pulse == 1'b0)
            next_state = 3'b111;
        else if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b1)
            next_state = 3'b000;
        else
            next_state = 3'b110;  
            
        //timer_mode(set state)
        3'b111:
        if (in1_pulse == 1'b0 && in2_pulse == 1'b0 && in2_long_pulse == 1'b0 && mode_pulse == 1'b1)
            next_state = 3'b100;
        else
            next_state = 3'b111;  
        
        default:    //only for format of case
            next_state = 3'b000;
                
    endcase

always @*
    //stop_watch(pause state)
    if (state == 3'b010) begin
        mode = 1'b0;
        
        count_enable = 1'b0;
        lap = 1'b0;
        rst_state = 1'b0;
        
        count_enable_2 = 1'b0;
        stop = 1'b0;
        setting = 1'b0;
    end
    //stop_watch(start state)
    else if (state == 3'b001) begin
        mode = 1'b0;
        
        count_enable = 1'b1;
        lap = 1'b0;
        rst_state = 1'b0;
        
        count_enable_2 = 1'b0;
        stop = 1'b0;
        setting = 1'b0;
    end
    //stop_watch(lap state)
    else if (state == 3'b011) begin
        mode = 1'b0;
        
        count_enable = 1'b1;
        lap = 1'b1;
        rst_state = 1'b0;
        
        count_enable_2 = 1'b0;
        stop = 1'b0;
        setting = 1'b0;
    end 
    //stop_watch(reset state)
    else if (state == 3'b000) begin
        mode = 1'b0;
        
        count_enable = 1'b0;
        lap = 1'b0;
        rst_state = 1'b1;
        
        count_enable_2 = 1'b0;
        stop = 1'b0;
        setting = 1'b0;
    end
    //timer_mode(stop state)
    else if (state == 3'b100) begin
        mode = 1'b1;
        
        count_enable_2 = 1'b0;
        stop = 1'b1;
        setting = 1'b0;
        
        count_enable = 1'b0;
        lap = 1'b0;
        rst_state = 1'b0;
    end
    //timer_mode(start state)
    else if (state == 3'b101) begin
        mode = 1'b1;
    
        count_enable_2 = 1'b1;
        stop = 1'b0;
        setting = 1'b0;
        
        count_enable = 1'b0;
        lap = 1'b0;
        rst_state = 1'b0;
    end
    //timer_mode(pause state)
    else if (state == 3'b110) begin
        mode = 1'b1;
        
        count_enable_2 = 1'b0;
        stop = 1'b0;
        setting = 1'b0;
        
        count_enable = 1'b0;
        lap = 1'b0;
        rst_state = 1'b0;
    end 
    //timer_mode(set state)
    else begin
        mode = 1'b1;
        
        count_enable_2 = 1'b0;
        stop = 1'b1;
        setting = 1'b1;
    
        count_enable = 1'b0;
        lap = 1'b0;
        rst_state = 1'b0;
    end

//FSM state transition
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        state <= 3'b000;
    else
        state <= next_state;

endmodule