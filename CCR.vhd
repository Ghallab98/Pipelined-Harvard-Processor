LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity CCR is 
	port(
		clk 		: in std_logic;
		C_ccr_In 	: in std_logic;
		Z_ccr_In 	: in std_logic;
		N_ccr_In 	: in std_logic;
		C_ccr_Out	: out std_logic;
		Z_ccr_Out	: out std_logic;
		N_ccr_Out 	: out std_logic
	);
end CCR;

architecture reg_CCR of CCR is
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			C_ccr_Out <= C_ccr_In;
			Z_ccr_Out <= Z_ccr_In;
			N_ccr_Out <= N_ccr_In;
		end if;
	end process;
end reg_CCR;