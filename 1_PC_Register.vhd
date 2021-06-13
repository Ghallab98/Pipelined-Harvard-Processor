LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity PC_Register is 
	generic(n : integer := 32 );
	port(
		   clk : in std_logic;
		   d : in std_logic_vector(n-1 downto 0);
		   q : out std_logic_vector(n-1 downto 0)
	);
end PC_Register;

architecture PC_Register_arch of PC_Register is
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
				q <= d;
		end if;
	end process;
end PC_Register_arch;