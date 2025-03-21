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
    repeat (6) begin
      $display("Instruction = %b imm = %b at time %0d", uut.instruction, uut.imm, $time);
      #10;
    end
    $display("Processor testbench completed TIME:%0d", $time);
    #2000;
    $finish;
  end
endmodule
