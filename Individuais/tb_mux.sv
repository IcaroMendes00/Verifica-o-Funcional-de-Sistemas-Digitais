`include "mux.sv"

module tb_mux();
  
  logic CLK_0, CLK_1, CLK_2, CLK_3, CLK_4, CLK_5, OUT;
  bit[2:0] SEL; 
  int controle = 2000;
  
  mux meu_mux
  (
    .sel(SEL), 
    .in_5(CLK_5), 
    .in_4(CLK_4), 
    .in_3(CLK_3), 
    .in_2(CLK_2), 
    .in_1(CLK_1), 
    .in_0(CLK_0), 
    .out_mux(OUT)
  );    

  covergroup CG_A @(SEL); 
     coverpoint SEL
     {
       bins a[] = {[0:5]};
     }    
  endgroup
  
  CG_A cg_a_inst = new;
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(0);
    
    setTo0;
    
    while(cg_a_inst.get_coverage() < 100) begin
      checkSel;
    end
    
    #10000 
    $finish();

  end
    
    forever begin
        #50 CLK_0 = ~CLK_0;
        #100 CLK_1 = ~CLK_1;
        #200 CLK_2 = ~CLK_2;
        #300 CLK_3 = ~CLK_3;
        #400 CLK_4 = ~CLK_4;
        #500 CLK_5 = ~CLK_5;
    end

endmodule

task setTo0;
    CLK_1 = 0;
    CLK_2 = 0;
    CLK_3 = 0;
    CLK_4 = 0;
    CLK_5 = 0;
    CLK_0 = 0;
endtask

function int checkValue
(
    input bit [2:0] SEL,
    input logic CLK_0,
    input logic CLK_1,
    input logic CLK_2,
    input logic CLK_3,
    input logic CLK_4,
    input logic CLK_5,
    input logic OUT,
    inout int controle
);

  begin
    case (SEL)
        0: if (OUT != CLK_0) begin
            $display($time, "\nErro no mux 0!");
            $finish();
        end
        1: if (OUT != CLK_1) begin
            $display($time, "\nErro no mux 1!");
            $finish();
        end
        2: if (OUT != CLK_2) begin
            $display($time, "\nErro no mux 2!");
            $finish();
        end
        3: if (OUT != CLK_3) begin
            $display($time, "\nErro no mux 3!");
            $finish();
        end
        4: if (OUT != CLK_4) begin
           $display($time, "\nErro no mux 4!");
            $finish();
        end
        5: if (OUT != CLK_5)  begin 
            $display($time, "\nErro no mux 5!");
            $finish();
        end
        default: controle = 1;
    endcase
    return 0;
  end
endfunction

task checkSel;    
    if (controle == 0) begin 
        SEL = $urandom_range(0, 5); 
    end
    checkValue(SEL, CLK_0, CLK_1, CLK_2, CLK_3, CLK_4, CLK_5, OUT);
    controle--;
endtask