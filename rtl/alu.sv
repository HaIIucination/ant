// Check for missing cases R-Type and I-Type
`include "../rtl/opcodes.sv"

module alu (
    input [ 6:0] opcode,
    input [ 2:0] func3,
    input [ 6:0] func7,
    input [31:0] imm,

    input [31:0] a,
    input [31:0] b,
    output reg [31:0] result
);
  always_comb begin : ALU
    case (opcode)
      `R_TYPE:  //R-Type
      case (func3)
        3'b000:  result = func7[5] ? b - a : a + b;  // ADD or SUB
        3'b101:  result = a >> (b & 32'h0x1F);  // SRL
        3'b001:  result = a << (b & 32'h0x1F);  // SLL
        3'b010:  result = (a < b) ? 1 : 0;  // STL
        3'b100:  result = a ^ b;  // XOR
        3'b110:  result = a | b;  // OR
        3'b111:  result = a & b;  // AND
        default: result = 32'b0;
      endcase

      `I_TYPE:  //I-Type
      case (func3)
        3'b000:  result = a + imm;  //ADDI
        3'b010:  result = (a < imm) ? 1 : 0;  // STLI
        3'b100:  result = a ^ imm;  // XORI
        3'b110:  result = a | imm;  // ORI
        3'b111:  result = a & imm;  // ANDI
        default: result = 32'b0;
      endcase

      default: result = 32'b0;
    endcase
  end
endmodule
