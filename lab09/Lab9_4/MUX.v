module MUX(
    digit0,
    digit1,
    digit2,
    digit3,
    digit,
    key_down,
    capital
);
output [3:0] digit0, digit1, digit2, digit3;
input [4:0] digit;
input [511:0] key_down;
input capital;
reg [3:0] digit0, digit1, digit2, digit3;
reg [6:0] value, val_cal;

always@*
    if (key_down != 0 && (capital && (~key_down[18] && ~key_down[89]) || ~capital && (key_down[18] || key_down[89])))   //capital case
    begin
        case(digit)
            5'd0:  value=7'd65;
            5'd1:  value=7'd66;
            5'd2:  value=7'd67;
            5'd3:  value=7'd68;
            5'd4:  value=7'd69;
            5'd5:  value=7'd70;
            5'd6:  value=7'd71;
            5'd7:  value=7'd72;
            5'd8:  value=7'd73;
            5'd9:  value=7'd74;
            5'd10: value=7'd75;
            5'd11: value=7'd76;
            5'd12: value=7'd77;
            5'd13: value=7'd78;
            5'd14: value=7'd79;
            5'd15: value=7'd80;
            5'd16: value=7'd81;
            5'd17: value=7'd82;
            5'd18: value=7'd83;
            5'd19: value=7'd84;
            5'd20: value=7'd85;
            5'd21: value=7'd86;
            5'd22: value=7'd87;
            5'd23: value=7'd88;
            5'd24: value=7'd89;
            5'd25: value=7'd90;
            default: value=7'd0;
        endcase
    end
    else if (key_down != 0 && (~capital && (~key_down[18] && ~key_down[89]) || capital && (key_down[18] || key_down[89])))  //lower case
    begin
        case(digit)
            5'd0:  value=7'd97;
            5'd1:  value=7'd98;
            5'd2:  value=7'd99;
            5'd3:  value=7'd100;
            5'd4:  value=7'd101;
            5'd5:  value=7'd102;
            5'd6:  value=7'd103;
            5'd7:  value=7'd104;
            5'd8:  value=7'd105;
            5'd9:  value=7'd106;
            5'd10: value=7'd107;
            5'd11: value=7'd108;
            5'd12: value=7'd109;
            5'd13: value=7'd110;
            5'd14: value=7'd111;
            5'd15: value=7'd112;
            5'd16: value=7'd113;
            5'd17: value=7'd114;
            5'd18: value=7'd115;
            5'd19: value=7'd116;
            5'd20: value=7'd117;
            5'd21: value=7'd118;
            5'd22: value=7'd119;
            5'd23: value=7'd120;
            5'd24: value=7'd121;
            5'd25: value=7'd122;
            default: value=7'd0;
        endcase
    end
    else
        value=1'd0; //default value

always@*
    if (value >= 7'd100)
    begin
        digit3 = 4'b1111;
        digit2 = value / 100;
        val_cal = value % 100;
        digit1 = val_cal / 10;
        digit0 = val_cal % 10;
    end
    else if (value >= 7'd10 && value <= 7'd99)
    begin 
        digit3 = 4'b1111;
        digit2 = 4'b1111;
        digit1 = value / 10;
        digit0 = value % 10;
    end
    else    //value = 7'd0
    begin
        digit3 = 4'b1111;
        digit2 = 4'b1111;
        digit1 = 4'b1111;
        digit0 = 4'b1111;
    end
    

endmodule
