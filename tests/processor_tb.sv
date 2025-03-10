`include "../rtl/processor.sv"
module processor_tb;

  reg clock;
  reg reset;

  processor uut (
      .clock(clock),
      .reset(reset)
  );
  always #5 clock = ~clock;

  initial begin
    $display("Starting Processor testbench");
    clock = 0;
    reset = 1;
    #5;
    reset = 0;
    repeat (3) begin
      $display("Instruction = %b", uut.instruction);
      #10;
    end
    $display("Processor testbench completed");
    $finish;
  end
endmodule
