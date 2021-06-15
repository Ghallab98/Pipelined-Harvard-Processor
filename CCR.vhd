LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity CCR is 
	port(
		clk 		: in std_logic;
		rst		: in std_logic;
		CCR_In		: in std_logic_vector (2 downto 0 );
		CCR_Out		: out std_logic_vector (2 downto 0 )
	);
end CCR;

architecture reg_CCR of CCR is
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			
			if (rst = '1') then
				CCR_Out <= (others=>'0');
			else 
				CCR_Out <= CCR_In;
			end if;
		end if;
	end process;
	

end reg_CCR;