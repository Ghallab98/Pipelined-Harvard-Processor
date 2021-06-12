library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity decoder is
port(
enable : in STD_LOGIC; 
address : in STD_LOGIC_VECTOR(2 downto 0);
output : out STD_LOGIC_VECTOR(7 downto 0)
);
end decoder;
architecture my_decoder of decoder is
begin
 
process(address)
begin
 	if (address="000" and enable='1') then
 		output <= "00000001";
 	elsif (address="001" and enable='1') then
 		output <= "00000010";
 	elsif (address="010" and enable='1') then
 		output <= "00000100";
 	elsif (address="011" and enable='1') then
 		output <= "00001000";
	elsif (address="100" and enable='1') then
 		output <= "00010000";
 	elsif (address="101" and enable='1') then
 		output <= "00100000";
 	elsif (address="110" and enable='1') then
 		output <= "01000000";
 	elsif (address="111" and enable='1') then
 		output <= "10000000";
	elsif (enable='0') then 
		output <= "00000000";
	else 
		output <= "XXXXXXXX";
 	end if;
end process;
end architecture;

