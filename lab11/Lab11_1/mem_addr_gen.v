module mem_addr_gen(
  input enable,
  input clk,
  input rst,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  output [16:0] pixel_addr
);
    
reg [7:0] position, position_tmp;
  
assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1) + position * 320)% 76800;  //640*480 --> 320*240 

always @*
    if (position < 239 && enable)
        position_tmp = position + 1;
    else if (position < 239 && ~enable)
        position_tmp = position;
    else
        position_tmp = 0;

always @ (posedge clk or posedge rst) begin
  if(rst)
    position <= 0;
  else
    position <= position_tmp;
end
    
endmodule
