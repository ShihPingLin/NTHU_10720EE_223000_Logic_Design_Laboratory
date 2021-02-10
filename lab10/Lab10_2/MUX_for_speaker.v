module MUX_for_speaker(
    note_div,
    value
);
output [21:0] note_div;
input [6:0] value;
reg [21:0] note_div;


always @*
     if (value == 7'd99)
        note_div = 22'd191571;  //Mid Do
     else if (value == 7'd100)
        note_div = 22'd170648;  //Mid Re
     else if (value == 7'd101)
        note_div = 22'd151515;  //Mid Mi
     else if (value == 7'd102)
        note_div = 22'd143266;  //Mid Fa
     else if (value == 7'd103)
        note_div = 22'd127551;  //Mid So
     else if (value == 7'd97)
        note_div = 22'd113636;  //Mid La
     else if (value == 7'd98)
        note_div = 22'd101215;  //Mid Si
     else if (value == 7'd67)
        note_div = 22'd95420;   //High Do
     else if (value == 7'd68)
        note_div = 22'd85034;   //High Re
     else if (value == 7'd69)
        note_div = 22'd75758;   //High Mi
     else if (value == 7'd70)
        note_div = 22'd71633;   //High Fa
     else if (value == 7'd71)
        note_div = 22'd63775;   //High So
     else if (value == 7'd65)
        note_div = 22'd56818;   //High La
     else if (value == 7'd66)
        note_div = 22'd50607;   //High Si
     else
        note_div = 22'd1;
        
 endmodule