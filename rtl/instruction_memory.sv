module instruction_memory (
    input reset,
    input [31:0] pc,
    output [31:0] instruction
);
  reg [31:0] memory[8];

  assign instruction = memory[pc>>2];

  always @(posedge reset) begin
    //store 14 in register[1]
    memory[0] = 32'b000000001110_00000_000_00001_0010011;
    //store 11 in register[2]
    memory[1] = 32'b000000001011_00000_000_00010_0010011;
    //register[1] + register[2] and store in register[3]
    memory[2] = 32'b0000000_00010_00001_000_00011_0110011;
  end
endmodule
