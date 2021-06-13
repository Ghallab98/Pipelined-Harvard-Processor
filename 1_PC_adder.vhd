Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY PC_adder is
	GENERIC (n: integer :=32);
	port(
		PC_Address 	: in std_logic_vector(n-1 downto 0);
		PC_next_Address : out std_logic_vector(n-1 downto 0)
	 );

end ENTITY;

Architecture my_Counter of PC_adder is
Begin
	PC_next_Address <= std_logic_vector(unsigned(PC_Address)+1);
end Architecture;
