Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY PC_adder is
	GENERIC (n: integer :=20);
	port(
		CLK 		: in std_logic;
		PC_Address 	: in std_logic_vector(n-1 downto 0);
		PC_next_Address : out std_logic_vector(n-1 downto 0)
	 );

end ENTITY;

Architecture my_Counter of PC_adder is
Begin
	PROCESS(CLK)
	VARIABLE count : INTEGER RANGE 0 TO (2**n) := 0;
	BEGIN 
	IF (rising_edge(CLK)) THEN
		IF(count = (2**n)) THEN
			count := 0;
		END IF;
	PC_next_Address <= std_logic_vector(to_unsigned(count,n));
	count := to_integer(unsigned(PC_Address))+1;
	END IF;
	END PROCESS;

end Architecture;
