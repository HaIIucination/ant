`include "../rtl/opcodes.sv"

module control_unit (
    input [6:0] opcode,
    input [2:0] func3,

    output reg store_enable,
    output reg load_enable,
    output reg [3:0] mem_write_enable,
    output reg reg_write
);

  always_comb begin : CONTROL
    reg_write = 0;
    store_enable = 0;
    load_enable = 0;
    mem_write_enable = 4'b0000;
    case (opcode)
      `R_TYPE: reg_write = 1;
      `I_TYPE: reg_write = 1;
      `S_TYPE: begin
        store_enable = 1;
        case (func3)
          3'b000:  mem_write_enable = 4'b0001;
          3'b001:  mem_write_enable = 4'b0011;
          3'b010:  mem_write_enable = 4'b1111;
          default: mem_write_enable = 4'b0000;
        endcase
      end
      `L_TYPE: begin
          reg_write = 1;
          load_enable = 1;
      end
      default: begin
        reg_write = 0;
        mem_write_enable = 4'b0000;
      end
    endcase
  end
endmodule
