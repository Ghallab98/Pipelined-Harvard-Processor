LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY instructionRam IS
	GENERIC(
	  DataWidth    : INTEGER := 16;
	  AddressWidth : INTEGER := 20
	  );
	PORT(
		clk     	: IN  std_logic;
		address 	: IN  std_logic_vector(AddressWidth-1 DOWNTO 0);
		writeEnable	: IN std_logic;
		datain 		: IN  std_logic_vector(DataWidth-1 DOWNTO 0);
		dataout		: OUT std_logic_vector(DataWidth-1 DOWNTO 0)
		);
END ENTITY instructionRam;

ARCHITECTURE ins_ram OF instructionRam IS

	TYPE ram_type IS ARRAY(0 TO (2**AddressWidth)-1) OF std_logic_vector(DataWidth-1 DOWNTO 0);
	SIGNAL ram : ram_type;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF writeEnable = '1' THEN
						ram(to_integer(unsigned(address)))   <= datain;
					END IF;
				END IF;
		END PROCESS;
		dataout <= ram(to_integer(unsigned(address)));
END ins_ram;
