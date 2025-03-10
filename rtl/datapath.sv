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
    input [31:0] imm
);

  wire [31:0] write_data;
  wire [31:0] read_data1;
  wire [31:0] read_data2;

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
