module reg_DecodeDisplay (reset, arm, cont_3, cont_2, cont_1, cont_0, bcd_3, bcd_2, bcd_1, bcd_0 );    
  input reset, arm;
  input [3:0] cont_3, cont_2, cont_1, cont_0;
  output logic [6:0] bcd_3, bcd_2, bcd_1, bcd_0;
endmodule
