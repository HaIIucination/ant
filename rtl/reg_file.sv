module reg_file (
    input clock,
    input reset,

    input  [ 4:0] reg_read1,
    input  [ 4:0] reg_read2,
    output [31:0] read_data1,
    output [31:0] read_data2,

    input reg_write,  //1 if data should be written
    input [4:0] write_reg,  //position for register that should be written
    input [31:0] write_data  // the data that should be written into register
);
  reg [31:0] register[32];

  assign read_data1 = register[reg_read1];
  assign read_data2 = register[reg_read2];


  always @(posedge reset) begin
      for(int i=0;i<32;i++) begin
          register[0] = 32'd0;
      end
  end

  always @(posedge clock) begin
    if (reg_write) begin
      register[write_reg] = write_data;
      $display("register[%d] = %d", write_reg, write_data);
    end
  end
endmodule
