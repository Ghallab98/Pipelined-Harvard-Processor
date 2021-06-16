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

		PC_out			: out std_logic_vector (n-1 downto 0);
		Immediate_Signal : in std_logic;
		PC_adder2_out : in std_logic_vector(31 downto 0)
	);
end entity PC_controlUnit;


architecture PC_CU of PC_controlUnit is
begin 
		PC_out <= (others=>'0') when rst = '1'
	else PC_rgst when (CU_call_signal = '1' and CU_PC_eq_PC_signal = '0' and CU_branch_signal = '0' and CU_Ret_signal = '0')
	else PC_eq_PC when (CU_call_signal = '0' and CU_PC_eq_PC_signal = '1' and CU_branch_signal = '0' and CU_Ret_signal = '0')
	else PC_rgst when (CU_call_signal = '0' and CU_PC_eq_PC_signal = '0' and CU_branch_signal = '1' and CU_Ret_signal = '0')
	else PC_wb when (CU_call_signal = '0' and CU_PC_eq_PC_signal = '0' and CU_branch_signal = '0' and CU_Ret_signal = '1')
	else PC_adder2_out when (CU_call_signal = '0' and CU_PC_eq_PC_signal = '0' and CU_branch_signal = '0' and CU_Ret_signal = '0' and Immediate_Signal = '1'
	else PC_next;
end PC_CU;