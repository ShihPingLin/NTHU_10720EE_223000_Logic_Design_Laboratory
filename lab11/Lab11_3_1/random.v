module random(
    random_nmb,
    clk,
    rst_n
);
output [2:0] random_nmb;    //random number from 0 to 7
input clk, rst_n;
reg [2:0] random_nmb;
reg q_tmp;
reg rst;
reg [8:0] q; 

always @*
    random_nmb = {q[2],q[3],q[4]};

always @*
    q_tmp = q[1] ^ q[6] ^ q[7] ^ q[8];

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        q <= 9'b101010101;
    else begin
        q[0] <= q_tmp;
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
        q[4] <= q[3];
        q[5] <= q[4];
        q[6] <= q[5];
        q[7] <= q[6];
        q[8] <= q[7];
    end

endmodule