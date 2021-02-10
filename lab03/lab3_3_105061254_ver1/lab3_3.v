module top_module(
    clk,    //global clock
    rst,    //active low reset
    q       //LED output
);

output [7:0] q;
input clk;
input rst;

wire clk_out;

//insert frequency divider
frequency_divider_n U0(
    .clk(clk),  //clock from the crystal
    .rst(rst),  //active low reset
    .clk_out(clk_out)   //divied clock output(connected to wire)
);

//insert shifter
shifter U1(
    .q(q),  //shifter output
    .clk(clk_out),  //clock from frequency divider
    .rst_n(rst)   //active low reset
);

endmodule