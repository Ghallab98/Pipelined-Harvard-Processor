LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity PC_controlUnit is 
	generic(n : integer := 32 );
	port(
		clk 			: in std_logic;
		rst 			: in std_logic;
		CU_call_signal	 	: in std_logic;
		CU_PC_eq_PC_signal 	: in std_logic;
		CU_branch_signal 	: in std_logic;
		CU_Ret_signal 		: in std_logic;

		PC_next			: in std_logic_vector (n-1 downto 0);
		PC_eq_PC		: in std_logic_vector (n-1 downto 0);
		PC_rgst			: in std_logic_vector (n-1 downto 0);
		PC_wb			: in std_logic_vector (n-1 downto 0);

		PC_out			: out std_logic_vector (n-1 downto 0)
	);
end entity PC_controlUnit;


architecture PC_CU of PC_controlUnit is
begin 

	process(clk)
	begin
		if (falling_edge(clk)) then
			if (rst = '1') then
				PC_out <= (others=>'0');
			elsif (CU_call_signal = '1' and CU_PC_eq_PC_signal = '0' and CU_branch_signal = '0' and CU_Ret_signal = '0'  ) then
				PC_out <= PC_rgst;
			elsif (CU_call_signal = '0' and CU_PC_eq_PC_signal = '1' and CU_branch_signal = '0' and CU_Ret_signal = '0'  ) then
				PC_out <= PC_eq_PC;
			elsif (CU_call_signal = '0' and CU_PC_eq_PC_signal = '0' and CU_branch_signal = '1' and CU_Ret_signal = '0'  ) then
				PC_out <= PC_rgst;
			elsif (CU_call_signal = '0' and CU_PC_eq_PC_signal = '0' and CU_branch_signal = '0' and CU_Ret_signal = '1'  ) then
				PC_out <= PC_wb;
			else 
				PC_out <= PC_next;
			end if;
		end if;
	end process;

end PC_CU;