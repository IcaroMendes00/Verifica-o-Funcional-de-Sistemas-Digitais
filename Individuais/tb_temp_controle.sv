`include "temp_controle.sv"

module tb_temp_controle();
  
  logic CLK_C, RESET, ARM, LIMP, HAB;
  int STATE = 0;
  
  temp_controle tb_temp_controle
  (
    .clk_controle(CLK_C),
    .reset(RESET),
    .arm(ARM),
    .limp(LIMP),
    .hab(HAB)
  );

  initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0);
    
    CLK_C = 0;  
    
    #10000 $finish();
    
  end
  
  always @(posedge CLK_C) begin
    checkState;       
   end 
  
  always #100 CLK_C = ~CLK_C;
  
endmodule

task checkState;
    case (STATE)
        0: begin
            if ((HAB != 0 || LIMP != 1 || ARM != 0)) begin
                $display($time, "\nErro: STATE 0 do controle!");
            end
        end
        1: begin
            if ((HAB != 0 || LIMP != 0 || ARM != 0)) begin
                $display($time, "\nErro: STATE 1 do controle!");
            end
        end
        2: begin
            if ((HAB != 1 || LIMP != 0 || ARM != 0)) begin
                $display($time, "\nErro: STATE 2 do controle!");
            end
        end
        3: begin
            if ((HAB != 0 || LIMP != 0 || ARM != 0)) begin
                $display($time, "\nErro: STATE 3 do controle!");
            end
        end
        4: begin
            if ((HAB != 0 || LIMP != 0 || ARM != 1)) begin
                $display($time, "\nErro: STATE 4 do controle!");
            end
        end
        5: begin
            if ((HAB != 0 || LIMP != 0 || ARM != 0)) begin
                $display($time, "\nErro: STATE 5 do controle!");
            end
        end
        default: STATE = 0;
    endcase

    if (STATE < 5) begin
        STATE = 0;
    end
    else begin
        STATE++;
    end

endtask

