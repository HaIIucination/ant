`include "../rtl/opcodes.sv"

module control_unit (
    input [6:0] opcode,
    input [2:0] func3,

    output reg store_enable,
    output reg [3:0] mem_write_enable,
    output reg reg_write
);

  always_comb begin : CONTROL
    case (opcode)
      `R_TYPE:  reg_write = 1;
      `I_TYPE:  reg_write = 1;
      `S_TYPE:
          store_enable = 1;
          case(func3)
              3'b000: mem_write_enable = 4'b0001;
              3'b001: mem_write_enable = 4'b0011;
              3'b010: mem_write_enable = 4'b1111;
             default: mem_write_enable = 4'b0000;
          endcase
      default: reg_write = 0;
    endcase
  end
endmodule
