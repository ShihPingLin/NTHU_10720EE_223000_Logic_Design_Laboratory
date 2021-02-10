module shifter(q, clk, rst_n);

output [7:0] q;
input clk;
input rst_n;
reg [7:0] q;

always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        q <= 8'b01010101;
    else begin
        q[0] <= q[7];
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
        q[4] <= q[3];
        q[5] <= q[4];
        q[6] <= q[5];
        q[7] <= q[6];
    end
end
endmodule
