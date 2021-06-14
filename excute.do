vsim -gui work.ex_stage
add wave -position insertpoint  \
sim:/ex_stage/AlU_C \
sim:/ex_stage/ALU_Mux_1_Output \
sim:/ex_stage/ALU_Mux_2_Output \
sim:/ex_stage/ALU_N \
sim:/ex_stage/ALU_Output \
sim:/ex_stage/ALU_Z \
sim:/ex_stage/AluSrc_Select \
sim:/ex_stage/CarryFlagOut \
sim:/ex_stage/CCR_C \
sim:/ex_stage/CCR_N \
sim:/ex_stage/CCR_Z \
sim:/ex_stage/clk \
sim:/ex_stage/empty \
sim:/ex_stage/EX_buffeur_output \
sim:/ex_stage/FU_1 \
sim:/ex_stage/FU_2 \
sim:/ex_stage/immValue \
sim:/ex_stage/In_port \
sim:/ex_stage/mux_1_Output \
sim:/ex_stage/n \
sim:/ex_stage/NegFlagOut \
sim:/ex_stage/opCode \
sim:/ex_stage/Rdst \
sim:/ex_stage/Rout \
sim:/ex_stage/Rsrc \
sim:/ex_stage/Rsrc_plus_immValue \
sim:/ex_stage/shiftImmValue \
sim:/ex_stage/WriteBackOutput \
sim:/ex_stage/ZeroFlagOut
force -freeze sim:/ex_stage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ex_stage/FU_1 00 0
force -freeze sim:/ex_stage/FU_2 00 0
force -freeze sim:/ex_stage/AluSrc_Select 00 0
force -freeze sim:/ex_stage/Rdst 10#128 0
force -freeze sim:/ex_stage/Rsrc 10#256 0
force -freeze sim:/ex_stage/shiftImmValue 0010 0

force -freeze sim:/ex_stage/shiftImmValue 00100 0
force -freeze sim:/ex_stage/immValue 10#1024 0
force -freeze sim:/ex_stage/opCode 0000 0
run

force -freeze sim:/ex_stage/In_port 16#FFFFFFFF 0
force -freeze sim:/ex_stage/opCode 0001 0
run
run
force -freeze sim:/ex_stage/opCode 0010 0
run
force -freeze sim:/ex_stage/opCode 0011 0
run
force -freeze sim:/ex_stage/opCode 0100 0
run
force -freeze sim:/ex_stage/opCode 0101 0
run
force -freeze sim:/ex_stage/opCode 0111 0
run
force -freeze sim:/ex_stage/opCode 1000 0
run
force -freeze sim:/ex_stage/opCode 1001 0
run
force -freeze sim:/ex_stage/opCode 1010 0
run
force -freeze sim:/ex_stage/opCode 1011 0
run
force -freeze sim:/ex_stage/opCode 1100 0
run
run
force -freeze sim:/ex_stage/opCode 1101 0
run
force -freeze sim:/ex_stage/opCode 1110 0
run
force -freeze sim:/ex_stage/opCode 1111 0
run