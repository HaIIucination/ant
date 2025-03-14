// Check for missing cases R-Type and I-Type
`include "../rtl/opcodes.sv"

module alu (
    input [ 6:0] opcode,
    input [ 2:0] func3,
    input [ 6:0] func7,
    input [31:0] imm,

    input signed [31:0] a,
    input signed [31:0] b,
    output reg signed [31:0] result,
    output reg branch,
    output reg jump
);
  wire [4:0] shmat = imm[4:0];
  always_comb begin : ALU
    branch = 0;
    jump   = 0;
    case (opcode)
      `R_TYPE:  //R-Type
      if (~func7[0]) begin
        case (func3)
          3'b000:  result = func7[5] ? b - a : a + b;  // ADD or SUB
          3'b001:  result = a << (b & 32'h0x1F);  // SLL
          3'b010:  result = ($signed(a) < $signed(b)) ? 1 : 0;  // STL
          3'b011:  result = (a < b) ? 1 : 0;  // STLU
          3'b100:  result = a ^ b;  // XOR
          3'b101:  result = func7[5] ? a >>> (b & 32'h0x1F) : a >> (b & 32'h0x1F);  // SRL or SRA
          3'b110:  result = a | b;  // OR
          3'b111:  result = a & b;  // AND
          default: result = 32'b0;
        endcase
      end else begin
        case (func3)
          // MUL considers only lower 32 bits
          3'b000:  result = (a * b) & 32'b11111111111111111111111111111111;  //MUL
          3'b010:  result = (a * b) >> 32;  //MULH
          3'b100:  result = $signed(a) / $signed(b);  //DIV
          3'b101:  result = a / b;  //DIVU
          3'b110:  result = $signed(a) % $signed(b);  //REM
          3'b111:  result = a % b;  //REMU
          default: result = 32'b0;
        endcase
      end
      `I_TYPE:  //I-Type
      case (func3)
        3'b000:  result = a + imm;  //ADDI
        3'b010:  result = ($signed(a) < $signed(imm)) ? 1 : 0;  // STLI
        3'b011:  result = (a < imm) ? 1 : 0;  // STLU
        3'b100:  result = a ^ imm;  // XORI
        3'b110:  result = a | imm;  // ORI
        3'b111:  result = a & imm;  // ANDI
        3'b001:  result = a << shmat;  //SLLI
        3'b101:  result = imm[10] ? $signed(a) >>> shmat : a >> shmat;  //SRLI and SRAI
        default: result = 32'b0;
      endcase
      `B_TYPE:
      case (func3)
        3'b000:  branch = (a == b);
        3'b001:  branch = (a != b);
        3'b100:  branch = ($signed(a) < $signed(b));
        3'b101:  branch = ($signed(a) >= $signed(b));
        3'b110:  branch = (a < b);
        3'b111:  branch = (a >= b);
        default: branch = 0;
      endcase
      default: result = 32'b0;
    endcase

  end
endmodule
