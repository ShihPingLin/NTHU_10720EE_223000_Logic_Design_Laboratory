module MUX_for_speaker(
    note_div_right,
    note_div_left,
    switch,
    value
);
output [21:0] note_div_right, note_div_left;
input switch;
input [6:0] value;
reg [21:0] note_div_right, note_div_left;


always @*
    if (switch == 1'b0) begin
        if (value == 7'd99) begin
            note_div_left = 22'd191571;  //Mid Do
            note_div_right = 22'd191571; 
        end
        else if (value == 7'd100) begin
            note_div_left = 22'd170648;  //Mid Re
            note_div_right = 22'd170648;
        end
        else if (value == 7'd101) begin
            note_div_left = 22'd151515;  //Mid Mi
            note_div_right = 22'd151515;
        end
        else if (value == 7'd102) begin
            note_div_left = 22'd143266;  //Mid Fa
            note_div_right = 22'd143266;
        end
        else if (value == 7'd103) begin
            note_div_left = 22'd127551;  //Mid So
            note_div_right = 22'd127551;
        end
        else if (value == 7'd97) begin
            note_div_left = 22'd113636;  //Mid La
            note_div_right = 22'd113636; 
        end
        else if (value == 7'd98) begin
            note_div_left = 22'd101215;  //Mid Si
            note_div_right = 22'd101215;
        end
        else if (value == 7'd67) begin
            note_div_left = 22'd95420;   //High Do
            note_div_right = 22'd95420;
        end
        else if (value == 7'd68) begin
            note_div_left = 22'd85034;   //High Re
            note_div_right = 22'd85034;
        end
        else if (value == 7'd69) begin
            note_div_left = 22'd75758;   //High Mi
            note_div_right = 22'd75758;
        end
        else if (value == 7'd70) begin
            note_div_left = 22'd71633;   //High Fa
            note_div_right = 22'd71633;
        end
        else if (value == 7'd71) begin
            note_div_left = 22'd63775;   //High So
            note_div_right = 22'd63775;
        end
        else if (value == 7'd65) begin
            note_div_left = 22'd56818;   //High La
            note_div_right = 22'd56818;
        end
        else if (value == 7'd66) begin
            note_div_left = 22'd50607;   //High Si
            note_div_right = 22'd50607; 
        end
     else begin
        note_div_left = 22'd1;
        note_div_right = 22'd1;
     end
    end
    else    //switch = 1 is on
    begin
        if (value == 7'd99) begin
            note_div_left = 22'd191571;  //Mid Do
            note_div_right = 22'd151515; 
        end
        else if (value == 7'd100) begin
            note_div_left = 22'd170648;  //Mid Re
            note_div_right = 22'd143266;
        end
        else if (value == 7'd101) begin
            note_div_left = 22'd151515;  //Mid Mi
            note_div_right = 22'd127551;
        end
        else if (value == 7'd102) begin
            note_div_left = 22'd143266;  //Mid Fa
            note_div_right = 22'd113636; 
        end
        else if (value == 7'd103) begin
            note_div_left = 22'd127551;  //Mid So
            note_div_right = 22'd101215;
        end
        else if (value == 7'd97) begin
            note_div_left = 22'd113636;  //Mid La
            note_div_right = 22'd95420; 
        end
        else if (value == 7'd98) begin
            note_div_left = 22'd101215;  //Mid Si
            note_div_right = 22'd85034;
        end
        else if (value == 7'd67) begin
            note_div_left = 22'd95420;   //High Do
            note_div_right = 22'd75758;
        end
        else if (value == 7'd68) begin
            note_div_left = 22'd85034;   //High Re
            note_div_right = 22'd71633;
        end
        else if (value == 7'd69) begin
            note_div_left = 22'd75758;   //High Mi
            note_div_right = 22'd63775;
        end
        else if (value == 7'd70) begin
            note_div_left = 22'd71633;   //High Fa
            note_div_right = 22'd56818;
        end
        else if (value == 7'd71) begin
            note_div_left = 22'd63775;   //High So
            note_div_right = 22'd50607; 
        end
        else if (value == 7'd65) begin
            note_div_left = 22'd56818;   //High La
            note_div_right = 22'd47755;
        end
        else if (value == 7'd66) begin
            note_div_left = 22'd50607;   //High Si
            note_div_right = 22'd42553; 
        end
        else begin
            note_div_left = 22'd1;
            note_div_right = 22'd1;
        end
   end
        
 endmodule