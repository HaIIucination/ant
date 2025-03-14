module memory_access_unit (
    input store_enable,
    input load_enable,
    input [31:0] base_addr,
    input [31:0] store_data,
    input [31:0] load_data,
    input [31:0] imm,
    input [2:0] func3,
    output reg [31:0] mem_store_data,
    output reg [31:0] mem_load_data,
    output [31:0] address
);
  assign address = base_addr + imm;

  always_comb begin : MEMORY_ACCESS
    if (store_enable) begin
      case (func3)
        3'b000:  mem_store_data = {24'b0, store_data[7:0]};  //SB
        3'b001:  mem_store_data = {16'b0, store_data[15:0]};  //SH
        3'b010:  mem_store_data = store_data; //SW
        default: mem_store_data = 32'b0;
      endcase
    end
    if (load_enable) begin
      case (func3)
        3'b000:  mem_load_data = {{24{load_data[7]}}, load_data[7:0]};  //LB
        3'b001:  mem_load_data = {{16{load_data[15]}}, load_data[15:0]};  //LH
        3'b010:  mem_load_data = load_data; //LW
        3'b100:  mem_load_data = {24'b0, load_data[7:0]};  //LB
        3'b101:  mem_load_data = {16'b0, load_data[15:0]};  //LH
        default: mem_load_data = 32'b0;
      endcase
      $display("mem_load_data = %0d", mem_load_data);
    end
  end
endmodule
