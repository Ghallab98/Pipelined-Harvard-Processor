Library ieee;
use ieee.std_logic_1164.all;

entity Decoder is
port(
enable: in std_logic;
S:in std_logic_vector(1 downto 0);
Choose: out std_logic_vector(3 downto 0));
end entity;

Architecture my_decoder of Decoder is
begin
Choose <= "1000" WHEN S = "00" and enable = '1'
Else "0100" WHEN S = "01" and enable = '1'
Else "0010" WHEN S = "10" and enable = '1'
Else "0001" WHEN S = "11" and enable = '1'
Else (OTHERS => '0');
end Architecture;