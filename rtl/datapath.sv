`include "../rtl/reg_file.sv"
`include "../rtl/alu.sv"

module datapath (
    input clock,
    input reset,
    input reg_write,
    input [4:0]rd,
    input [4:0]rs1,
    input [4:0]rs2,

    input [6:0] opcode,
    input [2:0] func3,
    input [6:0] func7,
    input [31:0] imm,
    input [3:0] mem_write_enable,
    input store_enable
);

  wire [31:0] write_data;
  wire [31:0] read_data1;
  wire [31:0] read_data2;
  wire [31:0] mem_write_data;
  wire [31:0] mem_read_data;
  wire [31:0] address = rs1 + imm;

  reg_file INST_REG (
      .clock(clock),
      .reset(reset),

      .reg_read1(rs1),
      .reg_read2(rs2),
      .read_data1(read_data1),
      .read_data2(read_data2),

      .reg_write (reg_write),
      .write_reg (rd),
      .write_data(write_data)
  );
store_unit INST_STORE(
    .base_reg(rs1),
    .store_data(rs2),
    .imm(imm),
    .func3(func3),
    .mem_write_data(mem_write_data),
);

memory INST_MEM(
    .address(address),
    .mem_write_data(mem_write_data),
    .mem_write_enable(mem_write_enable),
    .store_enable(store_enable),
    .mem_read_data(mem_read_data)
);

  alu INST_ALU (
      .opcode(opcode),
      .func3(func3),
      .func7(func7),
      .imm(imm),

      .a(read_data1),
      .b(read_data2),
      .result(write_data)
  );
endmodule
