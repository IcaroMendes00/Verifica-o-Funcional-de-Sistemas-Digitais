`include "reg_DecodeDisplay.sv"

module tb_reg_DecodeDisplay();
  
  logic [3:0] CONT_0, CONT_1, CONT_2, CONT_3;
  logic [6:0] BCD_0, BCD_1, BCD_2, BCD_3;
  logic RESET, ARM;
  logic ANT_ARM = 1;
  
  reg_DecodeDisplay tb_reg_dec
  (
    .reset(RESET), 
    .arm(ARM), 
    .cont_3(CONT_3), 
    .cont_2(CONT_2), 
    .cont_1(CONT_1), 
    .cont_0(CONT_0), 
    .bcd_3(BCD_3), 
    .bcd_2(BCD_2), 
    .bcd_1(BCD_1), 
    .bcd_0(BCD_0)
   );
  
   covergroup CG_0 @(CONT_0); 
     coverpoint CONT_0
     {
       bins a[] = {[0:9]};
     }    
  endgroup
  
  covergroup CG_1 @(CONT_1); 
     coverpoint CONT_1
     {
       bins a[] = {[0:9]};
     }    
  endgroup
  
  covergroup CG_2 @(CONT_2); 
     coverpoint CONT_2
     {
       bins a[] = {[0:9]};
     }    
  endgroup
  
  covergroup CG_3 @(CONT_3); 
     coverpoint CONT_3
     {
       bins a[] = {[0:9]};
     }    
  endgroup
  
  CG_0 cg_0_inst = new;
  CG_1 cg_1_inst = new;
  CG_2 cg_2_inst = new;
  CG_3 cg_3_inst = new;

    // 1111110 - 126
    // 0110000 - 48
    // 1101101 - 109
    // 1111001 - 121
    // 0110011 - 51
    // 1011011 - 91
    // 0011111 - 31
    // 1110000 - 112
    // 1111111 - 127
    // 1110011 - 115
  
  initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0);
    
    while((cg_0_inst.get_coverage() < 100 || cg_1_inst.get_coverage() < 100) || (cg_2_inst.get_coverage() < 100 || cg_3_inst.get_coverage() < 100)) begin
        if (ARM == 1 && ANT_ARM == 0) begin
            case_CONT_0; // CONT_0
            case_CONT_1; // CONT_1
            case_CONT_2; // CONT_2
            case_CONT_3; // CONT_3
            CONT_0 = $urandom_range(0, 9);
            CONT_1 = $urandom_range(0, 9);
            CONT_2 = $urandom_range(0, 9);
            CONT_3 = $urandom_range(0, 9);
            ANT_ARM = ARM;
        end    
    end
    
  end
  checkBCDReset;

endmodule

task checkBCDReset;
    if (RESET == 1) begin
        if (BCD_0 != 0 || BCD_1 != 0 || BCD_2 != 0 || BCD_3 != 0) begin
            $display($time, "\nErro encontrado no reset!");
            $finish();
        end
    end
endtask

function int checkBCD
(
    input logic [3:0] CONT_TST, 
    input logic [6:0] BCD_TST
);
    if (CONT_TST == 0) begin
        case (BCD_TST)
            0: return (BCD_TST != 126);
            1: return (BCD_TST != 48);
            2: return (BCD_TST != 109);
            3: return (BCD_TST != 121);
            4: return (BCD_TST != 51);
            5: return (BCD_TST != 91);
            6: return (BCD_TST != 31);
            7: return (BCD_TST != 112);
            8: return (BCD_TST != 127);
            9: return (BCD_TST != 115);
            default: return 1;
        endcase
    end
    return 0;
endfunction

task case_CONT_0;
    if (checkBCD(CONT_0, BCD_0) == 1) begin
        $display($time, "\nErro encontrado no BCD_0!");
        $finish();
    end
endtask

task case_CONT_1;
    if (checkBCD(CONT_1, BCD_1) == 1) begin
        $display($time, "\nErro encontrado no BCD_1!");
        $finish();
    end
endtask

task case_CONT_2;
    if (checkBCD(CONT_2, BCD_2) == 1) begin
        $display($time, "\nErro encontrado no BCD_2!");
        $finish();
    end
endtask

task case_CONT_3;
    if (checkBCD(CONT_3, BCD_3) == 1) begin
        $display($time, "\nErro encontrado no BCD_3!");
        $finish();
    end
endtask