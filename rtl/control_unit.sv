`include "../rtl/opcodes.sv"

module control_unit (
    input [6:0] opcode,
    output reg_write
);

  always_comb begin : CONTROL
    reg_write = 0;
    case (opcode)
      R_TYPE:  reg_write = 1;
      I_TYPE:  reg_write = 1;
      default: reg_write = 0;
    endcase
  end
endmodule
