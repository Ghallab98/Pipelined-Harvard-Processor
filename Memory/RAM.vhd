Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY ram IS
GENERIC (n: integer :=8);
PORT (
RST : IN std_logic;
CLK : IN std_logic;
Write_Enable : IN std_logic;
Address : IN std_logic_vector(5 DOWNTO 0);
datain : IN std_logic_vector(n-1 DOWNTO 0);
dataout : OUT std_logic_vector(n-1 DOWNTO 0) );
END ENTITY ram;

ARCHITECTURE sync_ram_a OF ram IS
TYPE ram_type IS ARRAY(0 TO 63) of std_logic_vector(n-1 DOWNTO 0);
SIGNAL ram : ram_type ;
BEGIN
PROCESS(CLK) IS
BEGIN
IF(RST = '1') THEN
For i in 0 to 63 Loop
ram(i) <= (OTHERS => '0');
end loop;
END IF;
IF rising_edge(CLK) THEN
IF Write_Enable = '1' THEN
ram(to_integer(unsigned((Address)))) <= datain;
END IF;
END IF;
END PROCESS;
dataout <= ram(to_integer(unsigned((Address))));
END sync_ram_a;