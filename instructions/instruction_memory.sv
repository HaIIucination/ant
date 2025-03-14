module instruction_memory (
    input reset,
    input [31:0] pc,
    output [31:0] instruction
);
  reg [31:0] inst_memory[256];
  integer fd;
  assign instruction = inst_memory[pc>>2];

  always @(posedge reset) begin
    $display("Time: %0t - Starting file read", $time);
    $readmemb("../instructions/store_test_bin.txt", inst_memory);
    $display("Time: %0t - File read completed", $time);
  end
endmodule
