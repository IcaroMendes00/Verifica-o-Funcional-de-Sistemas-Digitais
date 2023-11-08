module clk_sist(clk_in_50M, reset, clk_out_100K);
	 	 
  input clk_in_50M, reset;
  output bit clk_out_100K;
  
  logic [7:0] contador;
    
  always_ff @(posedge clk_in_50M, negedge reset)
    begin
      if (reset == 0) begin
        clk_out_100K = 0;
        contador = 0;
      end
      else
        if (contador == 250) begin
            clk_out_100K = ~clk_out_100K;
            contador = 0;
         end
         else begin
            contador = contador + 1;
         end
    end
endmodule
