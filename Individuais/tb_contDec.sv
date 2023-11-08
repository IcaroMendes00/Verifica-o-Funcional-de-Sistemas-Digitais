`include "contDec.sv"

module tb_dec();
  
  logic CLK_IN;
  wire CLK_OUT;
  logic RESET;
  
  int PULSE_COUNTER = 0;
  logic B_STATE = 0;
  
  contDec tb_contDec
  (
    .clk_in(CLK_IN),
    .reset(RESET),
    .clk_out(CLK_OUT)
  );
  
  initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0);
    
    CLK_IN = 0;
    
    #100000 $finish();
    
  end
  
  always @(posedge CLK_IN, CLK_OUT) begin
    checkCLK;   
  end
  
  always checkReset;

  always #500 CLK_IN = ~CLK_IN;
  
endmodule

task checkReset;
    begin
        if (RESET == 1 && CLK_OUT == 1) begin
            $display($time, "\nErro no reset!");
            $finish();
        end
    end
endtask

task checkCLK;
    begin
        if (CLK_IN) begin
            PULSE_COUNTER++;
        end
        if (CLK_OUT != B_STATE) begin 
            if (PULSE_COUNTER != 10) begin
                $display($time, "\nErro na frequencia de saida do dec!");
                $finish();
            end
            PULSE_COUNTER = 0;
            B_STATE = CLK_OUT;      
        end
    end
endtask
