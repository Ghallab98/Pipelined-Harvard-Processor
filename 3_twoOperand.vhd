LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity twoOperand is 
GENERIC (n : integer := 32);
	port(
		R1		: in std_logic_vector (n-1 downto 0);
		R2		: in std_logic_vector (n-1 downto 0 );
		sel 		: in std_logic_vector (2 downto 0);
		immValue	: in std_logic_vector (4 downto 0 );
		Rout		: out std_logic_vector (n-1 downto 0);
		CarryFlagIn	: in std_logic;
		ZeroFlagIn	: in std_logic;
		NegFlagIn	: in std_logic;
		CarryFlagOut	: out std_logic;
		ZeroFlagOut	: out std_logic;
		NegFlagOut	: out std_logic


);
end twoOperand; 


Architecture a_twoOperand of twoOperand is
signal temp 		: std_logic;
signal extendedOutput	:  unsigned(n DOWNTO 0):=(others=>'0');
begin

extendedOutput 	<= 	('0'& unsigned(R2))				  when 	  sel = "000"
		else	(('0'&unsigned(R1)) + ('0'& unsigned(R2)))	  when   (sel = "001" or sel = "010")	--ADD 
		else	(('0'&unsigned(R1)) - ('0'& unsigned(R2)))	  when   sel = "011"			-- SUB
		else 	(('0'&unsigned(R1)) and ('0'& unsigned(R2)))	  when   sel = "100"			-- AND
		else 	(('0'&unsigned(R1)) or ('0'& unsigned(R2)))	  when   sel = "101"			-- OR
		else	shift_left(('0'&unsigned(R1)),to_integer(unsigned(immValue))) when   sel = "110"	--shift left 
		else 	shift_right(('0'&unsigned(R1)),to_integer(unsigned(immValue))) when   sel = "111";	--shift right 


CarryFlagOut 	<= extendedOutput(32)  when (sel = "110" or sel = "001" or sel = "010" or sel = "011")
		else CarryFlagIn;

temp 		<='1' when extendedOutput(31 DOWNTO 0) = (extendedOutput(31 DOWNTO 0)'range => '0') else '0';
ZeroFlagOut 	<=  temp;

NegFlagOut 	<=extendedOutput(31) 	when not (sel = "111")
		else NegFlagIn;


Rout <= std_logic_vector(extendedOutput(n-1 DOWNTO 0));



end a_twoOperand; 

