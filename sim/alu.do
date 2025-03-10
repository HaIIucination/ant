vlib work
vdel -all
vlib work

vlog ../rtl/opcodes.sv
vlog ../rtl/alu.sv

vlog ../tests/alu_tb.sv

vsim  -voptargs=+acc work.alu_tb

log -r *
add wave -r *

run -all
