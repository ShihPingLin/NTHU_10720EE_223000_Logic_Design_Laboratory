module bincnt(q, clk, rst_n);

output [3:0] q;
input clk;
input rst_n;

reg [3:0] q;
reg [3:0] q_tmp;

always @*
    q_tmp = q + 1'b1;

always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        q <= 4'd0;
    else
        q <= q_tmp;
end
endmodule