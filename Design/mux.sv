module mux (sel, in_5, in_4, in_3, in_2, in_1, in_0, out_mux);    
    input bit[2:0] sel;
    input bit in_0, in_1, in_2, in_3, in_4, in_5;
    output bit out_mux;
endmodule
