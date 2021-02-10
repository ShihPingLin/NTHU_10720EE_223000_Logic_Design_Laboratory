module mem_addr_gen(
  input clk,
  input rst,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  input [2:0] random_nmb,
  output reg [16:0] pixel_addr
);
    
reg [7:0] position;

//assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1)+ position*320 )% 76800;  //640*480 --> 320*240 

always@*
    if (h_cnt >= 220 && h_cnt < 420 && v_cnt >= 0 && v_cnt < 400) begin
        if (h_cnt >= 280 && h_cnt < 360 && v_cnt >= 0 && v_cnt < 20 && random_nmb == 3'b000) 
            pixel_addr = (h_cnt - 280) + 80 * v_cnt;
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= 0 && v_cnt < 40 && random_nmb == 3'b001) 
            pixel_addr = (h_cnt - 290) + 60 * v_cnt + 1600;                                     
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= 0 && v_cnt < 40 && random_nmb == 3'b010) 
            pixel_addr = (h_cnt - 290) + 60 * v_cnt + 4000;
        else if (h_cnt >= 300 && h_cnt < 340 && v_cnt >= 0 && v_cnt < 40 && random_nmb == 3'b011)
            pixel_addr = (h_cnt - 300) + 40 * v_cnt + 6400;
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= 0 && v_cnt < 40 && random_nmb == 3'b100)
            pixel_addr = (h_cnt - 290) + 60 * v_cnt + 8000;
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= 0 && v_cnt < 40 && random_nmb == 3'b101)
            pixel_addr = (h_cnt - 290) + 60 * v_cnt + 10400;
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= 0 && v_cnt < 40 && (random_nmb == 3'b110 || random_nmb == 3'b111))
            pixel_addr = (h_cnt - 290) + 60 * v_cnt + 12800;    
        else
            pixel_addr = 18000; //white  
    end
    else
        pixel_addr = 16400; //black
  
endmodule
