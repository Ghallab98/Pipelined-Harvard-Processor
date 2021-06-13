add wave sim:/if_stage/*
force -freeze sim:/if_stage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/if_stage/rst 1 0
force -freeze sim:/if_stage/CU_call_signal 0 0
force -freeze sim:/if_stage/CU_PC_eq_PC_signal 0 0
force -freeze sim:/if_stage/CU_branch_signal 0 0
force -freeze sim:/if_stage/CU_Ret_signal 0 0
force -freeze sim:/if_stage/rgst 16#00000000 0
force -freeze sim:/if_stage/wb 16#00000000 0
force -freeze sim:/if_stage/rgst 16#00000009 0
force -freeze sim:/if_stage/wb 16#00000005 0
mem load -filltype value -filldata 16#1111 -fillradix symbolic /if_stage/Ins_mem/ram(0)
mem load -filltype value -filldata 16#2222 -fillradix symbolic /if_stage/Ins_mem/ram(1)
mem load -filltype value -filldata 16#3333 -fillradix symbolic /if_stage/Ins_mem/ram(2)
mem load -filltype value -filldata 16#4444 -fillradix symbolic /if_stage/Ins_mem/ram(3)
mem load -filltype value -filldata 16#5555 -fillradix symbolic /if_stage/Ins_mem/ram(4)
mem load -filltype value -filldata 16#6666 -fillradix symbolic /if_stage/Ins_mem/ram(5)
mem load -filltype value -filldata 16#7777 -fillradix symbolic /if_stage/Ins_mem/ram(6)
mem load -filltype value -filldata 16#8888 -fillradix symbolic /if_stage/Ins_mem/ram(7)
mem load -filltype value -filldata 16#9999 -fillradix symbolic /if_stage/Ins_mem/ram(8)
mem load -filltype value -filldata 16#AAAA -fillradix symbolic /if_stage/Ins_mem/ram(9)
mem load -filltype value -filldata 16#BBBB -fillradix symbolic /if_stage/Ins_mem/ram(10)
mem load -filltype value -filldata 16#CCCC -fillradix symbolic /if_stage/Ins_mem/ram(11)
mem load -filltype value -filldata 16#DDDD -fillradix symbolic /if_stage/Ins_mem/ram(12)
mem load -filltype value -filldata 16#EEEE -fillradix symbolic /if_stage/Ins_mem/ram(13)
mem load -filltype value -filldata 16#FFFF -fillradix symbolic /if_stage/Ins_mem/ram(14)
run
force -freeze sim:/if_stage/rst 0 0
force -freeze sim:/if_stage/CU_call_signal 1 0
run
force -freeze sim:/if_stage/CU_call_signal 0 0
run
force -freeze sim:/if_stage/CU_PC_eq_PC_signal 1 0
run
force -freeze sim:/if_stage/CU_PC_eq_PC_signal 0 0
force -freeze sim:/if_stage/CU_branch_signal 1 0
run
force -freeze sim:/if_stage/CU_branch_signal 0 0
force -freeze sim:/if_stage/CU_Ret_signal 1 0
run
force -freeze sim:/if_stage/CU_Ret_signal 0 0
run
run
run