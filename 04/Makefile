compile-cpu:
	iverilog -o CPU_tb.vvp CPU_tb.v

sim-cpu:
	vvp CPU_tb.vvp

diff-bit:
	diff CPU.out CPU.cmp