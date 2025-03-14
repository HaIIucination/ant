vlib work
vdel -all
vlib work

vlog ../instructions/instruction_memory.sv
vlog ../rtl/instruction_fetch.sv
vlog ../rtl/opcodes.sv
vlog ../rtl/decoder.sv
vlog ../rtl/control_unit.sv
vlog ../rtl/memory_access_unit.sv
vlog ../rtl/reg_file.sv
vlog ../rtl/alu.sv
vlog ../rtl/datapath.sv
vlog ../rtl/processor.sv

vlog ../tests/processor_tb.sv

vsim -voptargs=+acc work.processor_tb

log -r *
add wave -r *

run -all
