`define FREQ_DIV_BIT 27

module freqdiv(
    clk_out,    //divided clock output
    clk,        //global clock input
    rst_n       //active low reset
);

output clk_out;
input clk;
input rst_n;

reg clk_out;    //clk output(in always block)
reg [`FREQ_DIV_BIT - 2:0] cnt;   //remainder of the counter
reg [`FREQ_DIV_BIT - 1:0] cnt_tmp;   //input to dff(in always block)

//combinational logic
always @*
    cnt_tmp = {clk_out, cnt}+ 1'b1;

//sequential logic
always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        {clk_out, cnt} <= `FREQ_DIV_BIT'd0;
    else
        {clk_out, cnt} <= cnt_tmp;
end

endmodule
