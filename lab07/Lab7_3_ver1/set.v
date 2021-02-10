`timescale 1ns / 1ps

module set(
    setting,
    min_set_0,
    min_set_1,
    hour_set_0,
    hour_set_1,
    min_ini,
    hour_ini,
    min_set,
    hour_set,
    clk,
    rst_n
);
output [3:0] min_set_0, min_set_1, hour_set_0, hour_set_1;
output [5:0] min_ini, hour_ini;
input min_set, hour_set, setting;
input clk, rst_n;
reg [3:0] min_set_0, min_set_1, hour_set_0, hour_set_1;
reg [5:0] min_ini, hour_ini;
reg [5:0] min_tmp, hour_tmp;

always @*
    if (setting == 1'b1 && min_set == 1'b1 && min_ini == 6'd59)
        min_tmp = 6'd0;
    else if (setting == 1'b1 && min_set == 1'b1 && min_ini != 6'd59)
        min_tmp = min_ini + 6'd1;
    else
        min_tmp = min_ini;

always @*
    if (setting == 1'b1 && hour_set == 1'b1 && hour_ini == 6'd23)
        hour_tmp = 6'd0;
    else if (setting == 1'b1 && hour_set == 1'b1 && hour_ini != 6'd23)
        hour_tmp = hour_ini + 6'd1;
    else
        hour_tmp = hour_ini;

always @(posedge clk or negedge rst_n)
    if (~rst_n) begin
        min_ini <= 6'd0;
        hour_ini <= 6'd0;
    end
    else begin
        min_ini <= min_tmp;
        hour_ini <= hour_tmp;
    end

//convert to two separate digits
always@*
begin
    min_set_1 = min_ini / 10;
    min_set_0 = min_ini % 10;
    hour_set_1 = hour_ini / 10;
    hour_set_0 = hour_ini % 10;
end

endmodule