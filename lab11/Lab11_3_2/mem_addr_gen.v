module mem_addr_gen(
  input clk,
  input rst_n,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  input [2:0] random_nmb,
  output reg [16:0] pixel_addr
);
    
reg [2:0] random_nmb2_tmp;
reg [2:0] random_nmb2;
reg [9:0] v_cnt_upper, v_cnt_lower;
reg [9:0] v_cnt_upper2, v_cnt_lower2;   //for rectangle bar
reg [9:0] v_cnt_upper_tmp, v_cnt_lower_tmp;
reg [9:0] v_cnt_upper_tmp2, v_cnt_lower_tmp2;   //for rectangle bar

//assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1)+ position*320 )% 76800;  //640*480 --> 320*240 

always@*
    if (h_cnt >= 220 && h_cnt < 420 && v_cnt >= 0 && v_cnt < 400) begin
        if (h_cnt >= 280 && h_cnt < 360 && v_cnt >= v_cnt_lower2 && v_cnt < v_cnt_upper2 && random_nmb2 == 3'b000) 
            pixel_addr = (h_cnt - 280) + 80 * (v_cnt - v_cnt_lower2);
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= v_cnt_lower && v_cnt < v_cnt_upper && random_nmb2 == 3'b001) 
            pixel_addr = (h_cnt - 290) + 60 * (v_cnt - v_cnt_lower) + 1600;                                     
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= v_cnt_lower && v_cnt < v_cnt_upper && random_nmb2 == 3'b010) 
            pixel_addr = (h_cnt - 290) + 60 * (v_cnt - v_cnt_lower) + 4000;
        else if (h_cnt >= 300 && h_cnt < 340 && v_cnt >= v_cnt_lower && v_cnt < v_cnt_upper  && random_nmb2 == 3'b011)
            pixel_addr = (h_cnt - 300) + 40 * (v_cnt - v_cnt_lower) + 6400;
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= v_cnt_lower && v_cnt < v_cnt_upper  && random_nmb2 == 3'b100)
            pixel_addr = (h_cnt - 290) + 60 * (v_cnt - v_cnt_lower) + 8000;
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= v_cnt_lower && v_cnt < v_cnt_upper  && random_nmb2 == 3'b101)
            pixel_addr = (h_cnt - 290) + 60 * (v_cnt - v_cnt_lower) + 10400;
        else if (h_cnt >= 290 && h_cnt < 350 && v_cnt >= v_cnt_lower && v_cnt < v_cnt_upper  && (random_nmb2 == 3'b110 || random_nmb2 == 3'b111))
            pixel_addr = (h_cnt - 290) + 60 * (v_cnt - v_cnt_lower) + 12800;    
        else
            pixel_addr = 18000; //white  
    end
    else
        pixel_addr = 16400; //black

//random number renew or not
always @*
    if (v_cnt_upper == 10'd400 || v_cnt_upper2 == 10'd400)
        random_nmb2_tmp = random_nmb;
    else
        random_nmb2_tmp = random_nmb2;

always @(posedge clk or negedge rst_n)
    if (~rst_n)
        random_nmb2 <= random_nmb;
    else
        random_nmb2 <= random_nmb2_tmp;

//moving down
always @*
    if (v_cnt_upper == 10'd400) begin
        v_cnt_lower_tmp = 10'd0;
        v_cnt_upper_tmp = 10'd40;
    end
    else if (random_nmb2 != 3'b000)begin
        v_cnt_lower_tmp = v_cnt_lower + 10'd20;
        v_cnt_upper_tmp = v_cnt_upper + 10'd20;
    end
    else begin
        v_cnt_lower_tmp = 10'd0;
        v_cnt_upper_tmp = 10'd40;
    end

always @(posedge clk or negedge rst_n)
    if (~rst_n) begin
        v_cnt_lower <= 10'd0;
        v_cnt_upper <= 10'd40;
    end
    else begin
        v_cnt_lower <= v_cnt_lower_tmp;
        v_cnt_upper <= v_cnt_upper_tmp;
    end
    
always @*
    if (v_cnt_upper2 == 10'd400) begin
        v_cnt_lower_tmp2 = 10'd0;
        v_cnt_upper_tmp2 = 10'd20;
    end
    else if (random_nmb2 == 3'b000)begin
        v_cnt_lower_tmp2 = v_cnt_lower2 + 10'd20;
        v_cnt_upper_tmp2 = v_cnt_upper2 + 10'd20;
    end
    else begin
        v_cnt_lower_tmp2 = 10'd0;
        v_cnt_upper_tmp2 = 10'd20;
    end
    
always @(posedge clk or negedge rst_n)
    if (~rst_n) begin
        v_cnt_lower2 <= 10'd0;
        v_cnt_upper2 <= 10'd20;
    end
    else begin
        v_cnt_lower2 <= v_cnt_lower_tmp2;
        v_cnt_upper2 <= v_cnt_upper_tmp2;
    end
  
endmodule
