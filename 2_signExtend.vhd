LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
entity signExtend is 
	port(
		a: in std_logic_vector (15 downto 0);
		f: out std_logic_vector (31 downto 0)
	);
end entity;

Architecture myModel of signExtend is

signal extrabits :  std_logic_vector (15 downto 0);

begin
	extrabits(0)  <=  a(15);
	extrabits(1)  <=  a(15);
	extrabits(2)  <=  a(15);
	extrabits(3)  <=  a(15);
	extrabits(4)  <=  a(15);
	extrabits(5)  <=  a(15);
	extrabits(6)  <=  a(15);
	extrabits(7)  <=  a(15);
	extrabits(8)  <=  a(15);
	extrabits(9)  <=  a(15);
	extrabits(10) <=  a(15);
	extrabits(11) <=  a(15);
	extrabits(12) <=  a(15);
	extrabits(13) <=  a(15);
	extrabits(14) <=  a(15);
	extrabits(15) <=  a(15);


f<= extrabits & a;


end Architecture;