`include "../rtl/opcodes.sv"
module alu_tb;
  reg [6:0] opcode, func7;
  reg [2:0] func3;
  reg [31:0] imm, a, b;

  wire [31:0] result;

  alu uut (
      .opcode(opcode),
      .func3(func3),
      .func7(func7),
      .imm(imm),

      .a(a),
      .b(b),
      .result(result)
  );
  task automatic test_case;
      input  [6:0] test_opcode;
      input  [2:0] test_func3;
      input  [6:0] test_func7;
      input  [31:0] test_a, test_b, test_imm;
      input  [31:0]expected;
  begin
      opcode = test_opcode;
      func3 = test_func3;
      func7 = test_func7;
      imm = test_imm;
      a = test_a;
      b = test_b;

      #10;

      if(result!==expected)
     $display("TEST FAILED:opcode=%0b func3=%0b func7=%0b a=%0d b=%0d imm=%0d expected=%0d got=%0d",
                           opcode,    func3,    func7,    a,    b,    imm,    $signed(expected),  $signed(result));
      else
      $display("TEST PASSED:opcode=%b func3=%0b func7=%0b a=%0d b=%0d imm=%0d expected=%0d got=%0d",
                            opcode,   func3,    func7,    a,    b,    imm,    $signed(expected),  $signed(result));
  end
  endtask

 initial begin
        $display("Starting ALU testbench");
        // R-Type Tests
        test_case(7'b0110011, 3'b000, 7'b0000000, 32'd10, 32'd5, 0, 32'd15); // ADDinitial begin
        test_case(7'b0110011, 3'b000, 7'b0100000, 32'd10, 32'd5, 0, -32'sd5);// SUB
        test_case(7'b0110011, 3'b101, 7'b0000000, 32'd32, 32'd2, 0, 32'd8);  // SRL
        test_case(7'b0110011, 3'b001, 7'b0000000, 32'd2, 32'd3, 0, 32'd16); // SLL
        test_case(7'b0110011, 3'b010, 7'b0000000, 32'd5, 32'd10, 0, 32'd1); // SLT
        test_case(7'b0110011, 3'b100, 7'b0000000, 32'd15, 32'd9, 0, 32'd6); // XOR
        test_case(7'b0110011, 3'b110, 7'b0000000, 32'd12, 32'd5, 0, 32'd13); // OR
        test_case(7'b0110011, 3'b111, 7'b0000000, 32'd12, 32'd5, 0, 32'd4);  // AND
        //M-Extension test
        test_case(7'b0110011, 3'b000, 7'b0000001, 32'd12, 32'd5, 0, 32'd60);  // MUL
        test_case(7'b0110011, 3'b010, 7'b0000001, 32'd12, 32'd5, 0, 32'd0);  // HMUL
        test_case(7'b0110011, 3'b100, 7'b0000001, -32'sd12, 32'd3, 0, -32'sd4);  // DIV
        test_case(7'b0110011, 3'b101, 7'b0000001, 32'd12, 32'd3, 0, 32'd4);  // UDIV
        test_case(7'b0110011, 3'b110, 7'b0000001, -32'sd13, 32'd3, 0, -32'sd1);  // DIV
        test_case(7'b0110011, 3'b111, 7'b0000001, 32'd13, 32'd3, 0, 32'd1);  // DIV
        // I-Type Tests
        test_case(7'b0010011, 3'b000, 7'b0000000, 32'd10, 0, 32'd5, 32'd15); // ADDI
        test_case(7'b0010011, 3'b010, 7'b0000000, 32'd5, 0, 32'd10, 32'd1); // SLTI
        test_case(7'b0010011, 3'b100, 7'b0000000, 32'd15, 0, 32'd9, 32'd6); // XORI
        test_case(7'b0010011, 3'b110, 7'b0000000, 32'd12, 0, 32'd5, 32'd13); // ORI
        test_case(7'b0010011, 3'b111, 7'b0000000, 32'd12, 0, 32'd5, 32'd4);  // ANDI
        $display("ALU testbench completed");
        $finish;
    end
endmodule
