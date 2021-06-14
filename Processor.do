add wave sim:/processor/*
mem load -filltype value -filldata 16#1111 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(0)
mem load -filltype value -filldata 16#2222 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(1)
mem load -filltype value -filldata 16#3333 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(2)
mem load -filltype value -filldata 16#4444 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(3)
mem load -filltype value -filldata 16#5555 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(4)
mem load -filltype value -filldata 16#6666 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(5)
mem load -filltype alue -filldata 16#7777 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(6)
mem load -filltype value -filldata 16#8888 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(7)
mem load -filltype value -filldata 16#9999 -fillradix symbolic /processor/IF_inst/Ins_mem/ram(8)
mem load -filltype value -filldata 16#AAAA -fillradix symbolic /processor/IF_inst/Ins_mem/ram(9)
mem load -filltype value -filldata 16#BBBB -fillradix symbolic /processor/IF_inst/Ins_mem/ram(10)
mem load -filltype value -filldata 16#CCCC -fillradix symbolic /processor/IF_inst/Ins_mem/ram(11)
mem load -filltype value -filldata 16#DDDD -fillradix symbolic /processor/IF_inst/Ins_mem/ram(12)
mem load -filltype value -filldata 16#EEEE -fillradix symbolic /processor/IF_inst/Ins_mem/ram(13)
mem load -filltype value -filldata 16#FFFF -fillradix symbolic /processor/IF_inst/Ins_mem/ram(14)
force -freeze sim:/processor/CLK 0 0, 1 {50 ps} -r 100
force -freeze sim:/processor/RESET 1 0
run
force -freeze sim:/processor/RESET 0 0
run
