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

      clock=0;
      reset=1;

      #10;
      reset=0;

      repeat (4) begin
          #10;
          $display("PC = %0d, Instruction = %0b", uut.pc, instrutction);
      end
  end

endmodule
