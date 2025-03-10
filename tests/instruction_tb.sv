module instruction_tb;

  reg clock;
  reg reset;
  wire [31:0] instruction;

  instruction_fetch uut (
      .clock(clock),
      .reset(reset),
      .instruction(instruction)
  );
  always #5 clock = ~clock;

  initial begin
    $display("Starting Instruction Fetch testbench");

    clock = 0;
    reset = 1;

    #10;
    reset = 0;

    repeat (3) begin
      $display("PC = %0d, Instruction = %b", uut.pc, instruction);
      #10;
    end
    $finish;
  end
endmodule
