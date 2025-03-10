`include "../rtl/instruction_memory.sv"

module instruction_fetch (
    input clock,
    input reset,
    output [31:0] instruction
);

  reg [31:0] pc = 32'b0;

  instruction_memory INST_MEM (
      .reset(reset),
      .pc(pc),
      .instruction(instruction)
  );

  always @(posedge clock or posedge reset) begin
    if (reset == 1) pc <= 0;
    else pc <= pc + 4;
  end
endmodule
