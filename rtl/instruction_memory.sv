module instruction_memory (
    input reset,
    input [31:0] pc,
    output [31:0] instruction
);
  reg [31:0] memory[8];

  assign instruction = memory[pc>>2];

  always @(posedge reset) begin
    //store 2 in register[1]
    memory[0] = 32'b000000001010_00000_000_00001_0010011;
    //store 9 in register[2]
    memory[1] = 32'b000000001001_00000_000_00010_0010011;
    //addi x3, x0, 0x0000 setting base address at x3
    memory[2] = 32'b000000000000_00000_000_00011_0010011;
    //sw x1, 0(x3)
    memory[3] = 32'b0000000_00001_00011_010_00000_0100011;
    //sw x2, 4(x3)
    memory[4] = 32'b0000000_00010_00011_010_00100_0100011;
  end
endmodule
