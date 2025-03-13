`include "../rtl/instruction_fetch.sv"
`include "../rtl/control_unit.sv"
`include "../rtl/decoder.sv"
`include "../rtl/datapath.sv"

module processor (
    input clock,
    input reset
);
  wire [31:0] instruction;
  wire [4:0] rd;
  wire [2:0] func3;
  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [6:0] func7;
  wire [31:0] imm;
  wire store_enable;
  wire [3:0] mem_write_enable;
  wire reg_write;

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
      .opcode(instruction[6:0]),
      .func3 (func3),

      .store_enable(store_enable),
      .mem_write_enable(mem_write_enable),
      .reg_write(reg_write)
  );

  datapath INST_DATAPATH (
      .clock(clock),
      .reset(reset),
      .reg_write(reg_write),
      .rd(rd),
      .rs1(rs1),
      .rs2(rs2),

      .opcode(instruction[6:0]),
      .func3(func3),
      .func7(func7),
      .imm(imm),
      .mem_write_enable(mem_write_enable),
      .store_enable(store_enable)
  );
endmodule
