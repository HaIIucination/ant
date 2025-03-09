`include "instruction_fetch.sv"
`include "decoder.sv"
`include "datapath.sv"

module processor (
    input clock,
    input reset
);
  wire [31:0] instruction;
  wire [ 4:0] rd;
  wire [ 2:0] func3;
  wire [ 4:0] rs1;
  wire [ 4:0] rs2;
  wire [ 6:0] func7;
  wire [31:0] imm;

  instruction_fetch INST_IFU (
      .clock(clock),
      .reset(reset),
      .instruction(instruction)
  );

  decoder INST_DECODER (
      .instruction(instruction),
      .rd(rd),
      .func3(func3),
      .func7(func7),
      .rs1(rs1),
      .rs2(rs2),
      .imm(imm)
  );

  control_unit INST_CONTROL (
      .opcode(opcode),
      .reg_write(reg_write)
  );

  datapath INST_DATAPATH (
      .clock(clock),
      .reset(reset),
      .reg_write(reg_write),
      .rd(rd),
      .rs1(rs1),
      .rs2(rs2),

      .opcode(opcode),
      .func3(func3),
      .func7(func7),
      .imm(imm)
  );
endmodule
