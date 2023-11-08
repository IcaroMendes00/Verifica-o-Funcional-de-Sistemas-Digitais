`include "cont_BCD.sv"

module tb_CONT_BCD();
  
  logic [3:0] CONT_0, CONT_1, CONT_2, CONT_3;
  logic LIMP, HAB;
  logic CLK_A;
  logic RESET;
  logic ANT = 1, ANT_CLK = 0;
  int COUNTER, R_COUNTER;
  
  cont_BCD tb_cont_BCD
  (
    .clk_amostra(CLK_A), 
    .reset(RESET), 
    .limp(LIMP), 
    .hab(HAB), 
    .cont_3(CONT_3), 
    .cont_2(CONT_2), 
    .cont_1(CONT_1), 
    .cont_0(CONT_0)
  );   
  
  initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0);   

    CLK_A = 0;    
    #10000 
    $finish();
  
  end
  
  // verifica a limpeza
  checkLimpeza;

  // verifica COUNTER
  checkCOUNTER;
  
  // verifica reset
  checkReset;
  
  always #500 CLK_A = ~CLK_A;
  
endmodule

task checkLimpeza;
    begin
        always_ff @(negedge LIMP) begin
            if (CONT_0 != 0) begin 
                $display($time, "Erro na limpeza do cont 0!");
                $finish(); 
            end
            if (CONT_1 != 0) begin 
                $display($time, "Erro na limpeza do cont 1!");
                $finish();
            end
            if (CONT_2 != 0) begin 
                $display($time, "Erro na limpeza do cont 2!");
                $finish(); 
            end
            if (CONT_3 != 0) begin 
                $display($time, "Erro na limpeza do cont 3!");
                $finish();
            end
        end
    end
endtask 

task checkCOUNTER;
    logic ANT;
    always begin
        if (HAB) begin
            if (CLK_A == 1 && ANT_CLK == 0) begin
                R_COUNTER++;
            end
            ANT_CLK = CLK_A;
            ANT = HAB;
        end
        else if (ANT) begin
            COUNTER = CONT_3 * 1000 + CONT_2 * 100 + CONT_1 * 10 + CONT_0;
            if (COUNTER != R_COUNTER) begin
                $display($time, "\nErro no cont!");
                $finish();
            end
            ANT = 0;
        end
    end
endtask

task checkReset;
    if (RESET == 1) begin
        if (CONT_0 != 0 || CONT_1 != 0 || CONT_2 != 0 || CONT_3 != 0) begin
            $display($time, "\nErro no reset!");
            $finish();
        end
    end
endtask