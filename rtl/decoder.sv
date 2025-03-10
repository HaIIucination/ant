`include "../rtl/opcodes.sv"

module decoder (
    input [31:0] instruction,

    output wire [4:0] rd,
    output wire [2:0] func3,
    output wire [4:0] rs1,
    output wire [4:0] rs2,
    output wire [6:0] func7,
    output reg [31:0] imm
);

  assign rd[4:0]     = instruction[11:7];
  assign func3[2:0]  = instruction[14:12];
  assign rs1[4:0]    = instruction[19:15];
  assign rs2[4:0]    = instruction[24:20];
  assign func7[6:0]  = instruction[31:25];

  always_comb begin : IMM_GEN
    case (instruction[6:0])
      `I_TYPE, 7'b0000011, 7'b1100111:
          imm = {{20{instruction[31]}}, instruction[30:20]};
      `S_TYPE:
          imm = {{20{instruction[31]}}, instruction[30:25], instruction[11:7]};
      `B_TYPE:
          imm = {{19{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
      `U_TYPE:
          imm = {instruction[31:12], 12'b0};
      `J_TYPE:
          imm = {{11{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
      default: imm = 32'b0;
    endcase
  end
endmodule
