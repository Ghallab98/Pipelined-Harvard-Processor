LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity oneOperand is 
GENERIC (n : integer := 32);
	port(
		R1		: in std_logic_vector (n-1 downto 0);
		sel 		: in std_logic_vector (2 downto 0);
		Rout		: out std_logic_vector (n-1 downto 0);
		CarryFlagIn	: in std_logic;
		ZeroFlagIn	: in std_logic;
		NegFlagIn	: in std_logic;
		CarryFlagOut	: out std_logic;
		ZeroFlagOut	: out std_logic;
		NegFlagOut	: out std_logic


);
end oneOperand; 


Architecture a_oneOperand of oneOperand is
signal temp 		: std_logic;
signal extendedOutput	:  unsigned(n DOWNTO 0):=(others=>'0');
begin

extendedOutput 	<= 	to_unsigned(0,n+1) 				when  (sel = "000" or sel = "010" )  	-- NOP , Clear Carry 
		else	('1' & to_unsigned(0,n)) 			when   sel = "001"			--Set Carry 
		else 	('0'& not (unsigned(R1))) 			when   sel = "011"			-- NOT Rsdt (inverter)
		else 	(to_unsigned(1,n+1) + ('0'& unsigned(R1)))	when   sel = "100"			-- Increment Rdst
		else 	(('0'& unsigned(R1)) - (to_unsigned(1,n+1)))	when   sel = "101"			-- Decrement Rdst 
		else 	('0'& (unsigned(R1))) 			when   (sel = "110" or sel = "111");		--IN , OUT


CarryFlagOut 	<= extendedOutput(32)  when not(sel = "000" or sel = "110" or sel = "111")
		else CarryFlagIn;

temp 		<='1' when extendedOutput(31 DOWNTO 0) = (extendedOutput(31 DOWNTO 0)'range => '0') else '0';
ZeroFlagOut 	<= temp when (sel = "011" or sel = "100" or sel = "101")
		 else ZeroFlagIn;
NegFlagOut 	<=extendedOutput(31) 	when (sel = "011" or sel = "100" or sel = "101")
		else NegFlagIn;


Rout <= std_logic_vector(extendedOutput(n-1 DOWNTO 0));



end a_oneOperand; 

