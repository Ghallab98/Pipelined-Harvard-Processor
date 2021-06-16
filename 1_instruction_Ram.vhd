LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY instruction_Ram IS
	GENERIC(
	  DataWidth    : INTEGER := 16;
	  AddressWidth : INTEGER := 32
	  --AddressSpace : INTEGER := 2147483647 --(2^31-1)
	  );
	PORT(
		address 	: IN  std_logic_vector(AddressWidth-1 DOWNTO 0);
		dataout		: OUT std_logic_vector(DataWidth-1 DOWNTO 0)
		);
END ENTITY instruction_Ram;

ARCHITECTURE ins_ram OF instruction_Ram IS

	TYPE ram_type IS ARRAY(0 TO 4095) OF std_logic_vector(DataWidth-1 DOWNTO 0);
	SIGNAL ram : ram_type;
	
BEGIN
		dataout <= ram(to_integer(unsigned(address)));
END ins_ram;
