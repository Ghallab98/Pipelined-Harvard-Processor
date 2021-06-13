vsim -gui work.register_file
add wave -position insertpoint  \
sim:/register_file/Clk \
sim:/register_file/databus_1 \
sim:/register_file/databus_2 \
sim:/register_file/enable_decoder_to_register \
sim:/register_file/enable_decoder_to_tristatebuffer_1 \
sim:/register_file/enable_decoder_to_tristatebuffer_2 \
sim:/register_file/n \
sim:/register_file/r0_output \
sim:/register_file/r1_output \
sim:/register_file/r2_output \
sim:/register_file/r3_output \
sim:/register_file/r4_output \
sim:/register_file/r5_output \
sim:/register_file/r6_output \
sim:/register_file/r7_output \
sim:/register_file/read_address_1 \
sim:/register_file/read_address_2 \
sim:/register_file/read_enable \
sim:/register_file/Rst \
sim:/register_file/write_address \
sim:/register_file/write_databus \
sim:/register_file/write_enable
force -freeze sim:/register_file/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/register_file/write_enable 1 0
force -freeze sim:/register_file/write_address 000 0
force -freeze sim:/register_file/write_databus 16#0 0
run
force -freeze sim:/register_file/write_address 001 0
force -freeze sim:/register_file/write_databus 16#1 0
run
force -freeze sim:/register_file/write_address 010 0
force -freeze sim:/register_file/write_databus 16#2 0
run
force -freeze sim:/register_file/write_address 011 0
force -freeze sim:/register_file/write_databus 16#3 0
run

force -freeze sim:/register_file/write_address 100 0
force -freeze sim:/register_file/write_databus 16#4 0
run

force -freeze sim:/register_file/write_address 101 0
force -freeze sim:/register_file/write_databus 16#5 0
run

force -freeze sim:/register_file/write_address 110 0
force -freeze sim:/register_file/write_databus 16#6 0
run

force -freeze sim:/register_file/write_address 111 0
force -freeze sim:/register_file/write_databus 16#7 0
run

run
force -freeze sim:/register_file/write_enable 0 0
force -freeze sim:/register_file/read_enable 1 0
force -freeze sim:/register_file/read_address_1 000 0
force -freeze sim:/register_file/read_address_2 111 0
run
force -freeze sim:/register_file/read_address_2 110 0
force -freeze sim:/register_file/read_address_1 010 0
run
