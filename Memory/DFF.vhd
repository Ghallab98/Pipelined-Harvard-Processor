Library ieee;
use ieee.std_logic_1164.all;

entity DFF is 
GENERIC (n: integer :=8);
port(
enable: in std_logic;
D : in std_logic_vector(7 downto 0);
CLK : in std_logic;
RST : in std_logic;
Q : out std_logic_vector(7 downto 0));
end entity;

Architecture my_DFF of DFF is
begin
PROCESS(CLK)
BEGIN
IF(RST = '1') THEN
	Q <= (OTHERS =>'0');
ELSIF rising_edge(clk) AND enable = '1' THEN
	Q <= D;
END IF;
end PROCESS;
end Architecture;