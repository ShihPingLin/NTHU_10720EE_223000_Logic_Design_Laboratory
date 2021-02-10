`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 00:06:39
// Design Name: 
// Module Name: display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//define segment codes
`define SS_0_N 8'b11010101
`define SS_1_T 8'b11100001
`define SS_2_H 8'b10010001
`define SS_3_U 8'b10000011
`define SS_4_E 8'b01100001
`define SS_5_E 8'b01100001

module display(
    D_ssd,
    ssd_ctl,
    clk_ctl,
    q
);
output [7:0] D_ssd;
output [3:0] ssd_ctl;
input [1:0] clk_ctl;
input [5:0] q;
reg [7:0] D_ssd;
reg [3:0] ssd_ctl;

always @*
begin
    if (clk_ctl == 2'b00)
        ssd_ctl = 4'b1110;
    else if (clk_ctl == 2'b01)
        ssd_ctl = 4'b1101;
    else if (clk_ctl == 2'b10)
        ssd_ctl = 4'b1011;
    else
        ssd_ctl = 4'b0111;
end

always @*
begin
    if (q == 6'b000001) begin
        case(clk_ctl)
            2'b00:D_ssd = `SS_0_N;
            2'b01:D_ssd = `SS_1_T;
            2'b10:D_ssd = `SS_2_H;
            2'b11:D_ssd = `SS_3_U;
            default: D_ssd = 8'b01110001;
        endcase
    end
    else if(q == 6'b000010) begin 
        case(clk_ctl)
            2'b00:D_ssd = `SS_1_T;
            2'b01:D_ssd = `SS_2_H;
            2'b10:D_ssd = `SS_3_U;
            2'b11:D_ssd = `SS_4_E;
            default: D_ssd = 8'b01110001;  
        endcase      
    end
    else if(q == 6'b000100) begin 
        case(clk_ctl)
            2'b00:D_ssd = `SS_2_H;
            2'b01:D_ssd = `SS_3_U;
            2'b10:D_ssd = `SS_4_E;
            2'b11:D_ssd = `SS_5_E;
            default: D_ssd = 8'b01110001;        
        endcase
    end
    else if(q == 6'b001000) begin 
        case(clk_ctl)
            2'b00:D_ssd = `SS_3_U;
            2'b01:D_ssd = `SS_4_E;
            2'b10:D_ssd = `SS_5_E;
            2'b11:D_ssd = `SS_0_N;
            default: D_ssd = 8'b01110001;        
        endcase
    end
    else if(q == 6'b010000) begin 
        case(clk_ctl)
            2'b00:D_ssd = `SS_4_E;
            2'b01:D_ssd = `SS_5_E;
            2'b10:D_ssd = `SS_0_N;
            2'b11:D_ssd = `SS_1_T;
            default: D_ssd = 8'b01110001;        
        endcase
    end
    else begin
        case(clk_ctl)
            2'b00:D_ssd = `SS_5_E;
            2'b01:D_ssd = `SS_0_N;
            2'b10:D_ssd = `SS_1_T;
            2'b11:D_ssd = `SS_2_H;
            default: D_ssd = 8'b01110001;        
        endcase
    end
end

endmodule