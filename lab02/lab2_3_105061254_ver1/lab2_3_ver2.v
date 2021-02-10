module ssd(D_ssd, d, ssd_ctl, i);
output [7:0] D_ssd;
output [3:0] d;
output [3:0] ssd_ctl;
input [3:0] i;

display U0(.D_ssd(D_ssd),.d(d),.i(i));

assign ssd_ctl = 4'b0000;

endmodule
