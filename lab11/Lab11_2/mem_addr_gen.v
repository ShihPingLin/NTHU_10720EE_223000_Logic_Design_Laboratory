module mem_addr_gen(
  input [3:0] digit0, digit1, digit2, digit3,
  input [3:0] digit4, digit5, digit6, digit7,
  input [3:0] operator,
  input clk,
  input rst,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  output reg [16:0] pixel_addr
);
//reg [16:0] pixel_addr;
//assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1))% 76800;  //640*480 --> 320*240 

always@*
    if (v_cnt >= 100 && v_cnt <= 105)
        pixel_addr = 10885;
    else if (v_cnt >= 250 && v_cnt <= 255)
        pixel_addr = 10885;
    else if (h_cnt < 155 && h_cnt > 135 && v_cnt < 160 && v_cnt > 140)   // dig3
    begin
        case (digit3)
            4'd0:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 23080);
            4'd1:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 23112);
            4'd2:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 23135);
            4'd3:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 23160);
            4'd4:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 23185);
            4'd5:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 23215);
            4'd6:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 23242);
            4'd7:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 23270);
            4'd8:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 44200);
            4'd9:pixel_addr = ((h_cnt - 135) + 320 * (v_cnt - 140) + 44230);
            default:pixel_addr = 100;
        endcase
    end
    else if (h_cnt < 175 && h_cnt > 155 && v_cnt < 160 && v_cnt > 140)   // dig2
    begin
        case (digit2)
            4'd0:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 23080);
            4'd1:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 23112);
            4'd2:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 23135);
            4'd3:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 23160);
            4'd4:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 23185);
            4'd5:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 23215);
            4'd6:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 23242);
            4'd7:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 23270);
            4'd8:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 44200);
            4'd9:pixel_addr = ((h_cnt - 155) + 320 * (v_cnt - 140) + 44230);
            default:pixel_addr = 100;
        endcase
    end
    else if (h_cnt < 310 && h_cnt > 290 && v_cnt < 160 && v_cnt > 140)   // operator
    begin
        case (operator)
            4'd10:pixel_addr = ((h_cnt - 290) + 320 * (v_cnt - 140) + 44255);    //plus '+'   
            4'd11:pixel_addr = ((h_cnt - 290) + 320 * (v_cnt - 140) + 44275);    //plus '-' 
            4'd12:pixel_addr = ((h_cnt - 290) + 320 * (v_cnt - 140) + 44300);    //plus '*"           
            default:pixel_addr = 100;
        endcase
    end
    else if (h_cnt < 455 && h_cnt > 435 && v_cnt < 160 && v_cnt > 140)   // dig1
    begin
        case (digit1)
            4'd0:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 23080);
            4'd1:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 23112);
            4'd2:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 23135);
            4'd3:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 23160);
            4'd4:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 23185);
            4'd5:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 23215);
            4'd6:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 23242);
            4'd7:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 23270);
            4'd8:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 44200);
            4'd9:pixel_addr = ((h_cnt - 435) + 320 * (v_cnt - 140) + 44230);
            default:pixel_addr = 100;
        endcase
    end
    else if (h_cnt < 475 && h_cnt > 455 && v_cnt < 160 && v_cnt > 140)   // dig0
    begin
        case (digit0)
            4'd0:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 23080);
            4'd1:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 23112);
            4'd2:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 23135);
            4'd3:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 23160);
            4'd4:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 23185);
            4'd5:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 23215);
            4'd6:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 23242);
            4'd7:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 23270);
            4'd8:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 44200);
            4'd9:pixel_addr = ((h_cnt - 455) + 320 * (v_cnt - 140) + 44230);
            default:pixel_addr = 100;
        endcase
    end
    else if (h_cnt < 445 && h_cnt > 425 && v_cnt < 210 && v_cnt > 190)   // '='
        pixel_addr = ((h_cnt - 425) + 320 * (v_cnt - 190) + 44330);
    else if (h_cnt < 545 && h_cnt > 525 && v_cnt < 210 && v_cnt > 190)   // dig7
    begin
        case (digit7)
            4'd1:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 23112);
            4'd2:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 23135);
            4'd3:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 23160);
            4'd4:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 23185);
            4'd5:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 23215);
            4'd6:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 23242);
            4'd7:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 23270);
            4'd8:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 44200);
            4'd9:pixel_addr = ((h_cnt - 525) + 320 * (v_cnt - 190) + 44230);
            default:pixel_addr = 100;
        endcase
    end
    else if (h_cnt < 565 && h_cnt > 545 && v_cnt < 210 && v_cnt > 190)   // dig6
    begin
        case (digit6)
            4'd0:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 23080);
            4'd1:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 23112);
            4'd2:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 23135);
            4'd3:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 23160);
            4'd4:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 23185);
            4'd5:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 23215);
            4'd6:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 23242);
            4'd7:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 23270);
            4'd8:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 44200);
            4'd9:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 44230);
            4'd11:pixel_addr = ((h_cnt - 545) + 320 * (v_cnt - 190) + 44275);    //plus '-' 
            default:pixel_addr = 100;
        endcase
    end
    else if (h_cnt < 585 && h_cnt > 565 && v_cnt < 210 && v_cnt > 190)   // dig5
    begin
        case (digit5)
            4'd0:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 23080);
            4'd1:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 23112);
            4'd2:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 23135);
            4'd3:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 23160);
            4'd4:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 23185);
            4'd5:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 23215);
            4'd6:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 23242);
            4'd7:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 23270);
            4'd8:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 44200);
            4'd9:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 44230);
            4'd11:pixel_addr = ((h_cnt - 565) + 320 * (v_cnt - 190) + 44275);    //plus '-' 
            default:pixel_addr = 100;
        endcase
    end
    else if (h_cnt < 605 && h_cnt > 585 && v_cnt < 210 && v_cnt > 190)   // dig4
    begin
        case (digit4)
            4'd0:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 23080);
            4'd1:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 23112);
            4'd2:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 23135);
            4'd3:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 23160);
            4'd4:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 23185);
            4'd5:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 23215);
            4'd6:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 23242);
            4'd7:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 23270);
            4'd8:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 44200);
            4'd9:pixel_addr = ((h_cnt - 585) + 320 * (v_cnt - 190) + 44230);
            default:pixel_addr = 100;
        endcase
    end
    else
        pixel_addr = 100;
    
endmodule
