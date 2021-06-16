vsim work.processor
mem load -i C:/Users/moh_p/Desktop/2operand.mem /processor/IF_inst/Ins_mem/ram
mem load -skip 0 -filltype rand -filldata 10#0 -fillradix symbolic /processor/MEM_inst/MemDebug/ram

add wave sim:/processor/*
add wave -position end  sim:/processor/ID_inst/RegisterFile/r0_output
add wave -position end  sim:/processor/ID_inst/RegisterFile/r1_output
add wave -position end  sim:/processor/ID_inst/RegisterFile/r2_output
add wave -position end  sim:/processor/ID_inst/RegisterFile/r3_output
add wave -position end  sim:/processor/ID_inst/RegisterFile/r4_output
add wave -position end  sim:/processor/ID_inst/RegisterFile/r5_output
add wave -position end  sim:/processor/ID_inst/RegisterFile/r6_output
add wave -position end  sim:/processor/ID_inst/RegisterFile/r7_output
add wave -position end  sim:/processor/EX_inst/ccr_reg/C_ccr_In
add wave -position end  sim:/processor/EX_inst/ccr_reg/Z_ccr_In
add wave -position end  sim:/processor/EX_inst/ccr_reg/N_ccr_In
add wave -position end  sim:/processor/EX_inst/ccr_reg/C_ccr_Out
add wave -position end  sim:/processor/EX_inst/ccr_reg/Z_ccr_Out
add wave -position end  sim:/processor/EX_inst/ccr_reg/N_ccr_Out

add wave sim:/processor/EX_inst/FU/*
add wave sim:/processor/EX_inst/alu_block/*
add wave sim:/processor/EX_inst/AlUmux1/*


force -freeze sim:/processor/CLK 0 0, 1 {50 ps} -r 100
force -freeze sim:/processor/CU_branch_signal 0 0
force -freeze sim:/processor/CU_Ret_signal 0 0
force -freeze sim:/processor/IN_PORT 10#5 0
force -freeze sim:/processor/RESET 1 0
run
force -freeze sim:/processor/RESET 0 0
run
force -freeze sim:/processor/IN_PORT 10#19 0
run
force -freeze sim:/processor/IN_PORT 16#FFFFFFFF 0
run
force -freeze sim:/processor/IN_PORT 16#FFFFF320 0
run