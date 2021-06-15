LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY GenRam IS
	GENERIC(
	  DataWidth    : INTEGER := 16;
	  AddressWidth : INTEGER := 32;
	  AddressSpace : INTEGER := 1048575 --(2^20-1)
	  );
	PORT(
		clk     : IN  std_logic;
		we      : IN  std_logic;
        re      : IN  std_logic;
		address : IN  std_logic_vector(AddressWidth-1 DOWNTO 0);
		datain : IN  std_logic_vector(AddressWidth-1 DOWNTO 0);
		dataout: OUT std_logic_vector(AddressWidth-1 DOWNTO 0)
		);
END ENTITY GenRam;

ARCHITECTURE RamArchi OF GenRam IS
	TYPE ram_type IS ARRAY(0 TO AddressSpace) OF std_logic_vector(DataWidth-1 DOWNTO 0);
	SIGNAL ram : ram_type;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF falling_edge(clk) THEN  
					IF we = '1' THEN
						ram(to_integer(unsigned(address)))   <=  datain(AddressWidth-17 downto 0 );
						ram(to_integer(unsigned(address))+1) <= datain(AddressWidth-1 downto AddressWidth-16 ) ;
					END IF;
				END IF;
                IF re = '1' THEN
                    dataout(AddressWidth-1 downto AddressWidth-16 ) <= ram(to_integer(unsigned(address))+1);
                    dataout(AddressWidth-17 downto 0 ) <=  ram(to_integer(unsigned(address)));
                END IF;
		END PROCESS;
END RamArchi;
