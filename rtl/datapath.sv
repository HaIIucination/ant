`include "../rtl/reg_file.sv"
`include "../rtl/memory_access_unit.sv"
`include "../rtl/memory.sv"
`include "../rtl/alu.sv"

module datapath (
    input clock,
    input reset,
    input reg_write,
    input [4:0] rd,
    input [4:0] rs1,
    input [4:0] rs2,
    input [6:0] opcode,
    input [2:0] func3,
    input [6:0] func7,
    input [31:0] imm,
    input [3:0] mem_write_enable,
    input store_enable,
    input load_enable,
    output branch,
    output jump
);

  wire [31:0] write_data;
  wire [31:0] read_data1;
  wire [31:0] read_data2;
  wire [31:0] mem_write_data;
  wire [31:0] mem_read_data;
  wire [31:0] mem_load_data;
  wire [31:0] address;

  reg_file INST_REG (
      .clock(clock),
      .reset(reset),

      .reg_read1 (rs1),
      .reg_read2 (rs2),
      .read_data1(read_data1),
      .read_data2(read_data2),

      .reg_write(reg_write),
      .write_reg(rd),
      .write_data(write_data),
      .mem_load_data(mem_load_data),
      .load_enable(load_enable)
  );

  memory_access_unit INST_STORE (
      .store_enable(store_enable),
      .load_enable(load_enable),
      .base_addr(read_data1),
      .store_data(read_data2),
      .load_data(mem_read_data),
      .imm(imm),
      .func3(func3),
      .mem_store_data(mem_write_data),
      .mem_load_data(mem_load_data),
      .address(address)
  );

  memory INST_MEM (
      .clock(clock),
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
      .branch(branch),
      .jump(jump),

      .a(read_data1),
      .b(read_data2),
      .result(write_data)
  );

endmodule
