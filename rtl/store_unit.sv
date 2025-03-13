module store_unit (
    input [31:0] base_addr,
    input [31:0] store_data,
    input [31:0] imm,
    input [2:0] func3,
    output reg [31:0] mem_write_data,
    output [31:0] address
);
  assign address = base_addr + imm;

  always_comb begin : STORE_UNIT
    case (func3)
      3'b000:  mem_write_data = {24'b0, store_data[7:0]};  //SB
      3'b001:  mem_write_data = {16'b0, store_data[15:0]};  //SH
      3'b010:  mem_write_data = store_data;
      default: mem_write_data = 32'b0;
    endcase
  end
endmodule
