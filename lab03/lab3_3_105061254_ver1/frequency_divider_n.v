module frequency_divider_n(clk, rst, clk_out);
output clk_out;
input clk, rst;
reg clk_out;
reg clk_out_tmp;
reg T;
reg [26:0] q_tmp;
reg [26:0] q;

always @*
begin        
    q_tmp = q + 27'd1;
    
    if (q_tmp == 27'd50000000) begin        //q has already count from 0 to 49999999(50M times)
        q_tmp = 27'd0;
        T = 1'b1;
    end
    else
        T = 1'b0;
    
    clk_out_tmp = clk_out ^ T;
end

always @(posedge clk or negedge rst)    //D-FF for counter
begin
    if (~rst)
        q <= 27'd0;
    else
        q <= q_tmp;
end

always @(posedge clk or negedge rst)    //T-FF
begin
    if (~rst)
        clk_out <= 1'b0;
    else
        clk_out <= clk_out_tmp;
end

endmodule