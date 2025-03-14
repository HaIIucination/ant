module memory (
    input clock,
    input [31:0] address,
    input [31:0] mem_write_data,
    input [3:0] mem_write_enable,
    input store_enable,
    output wire [31:0] mem_read_data
);
  reg [7:0] mem[256];
  wire [7:0] mem_addr = {address[7:2], 2'b00};

  assign mem_read_data = {mem[mem_addr+3], mem[mem_addr+2], mem[mem_addr+1], mem[mem_addr]};  //LOAD

  always @(posedge clock) begin
    if (store_enable) begin
      if (mem_write_enable[0]) mem[mem_addr] <= mem_write_data[7:0];
      if (mem_write_enable[1]) mem[mem_addr+1] <= mem_write_data[15:8];
      if (mem_write_enable[2]) mem[mem_addr+2] <= mem_write_data[23:16];
      if (mem_write_enable[3]) mem[mem_addr+3] <= mem_write_data[31:24];
      $display("Stored into memory at mem[%0d:%0d], Data: %0d at time %0d", mem_addr + 3, mem_addr,
               mem_write_data, $time);
    end
  end
  /*
  initial begin
    $monitor("address = %0d, at time %0d", mem_addr, $time);
    $monitor("mem_write_data = %0d, at time %0d", mem_write_data, $time);
  end
  */
  initial begin
    #1000;
    for (int i = 0; i < 256; i++) begin
      $display("mem[%0d] = %0d", i, mem[i]);
    end

  end
endmodule

