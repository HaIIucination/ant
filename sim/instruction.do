vlib work
vdel -all
vlib work

vlog ../rtl/instruction_memory.sv
vlog ../rtl/instruction_fetch.sv
vlog ../tests/instruction_tb.sv

vsim -voptargs=+acc work.instruction_tb

log -r *
add wave -r *

run -all
