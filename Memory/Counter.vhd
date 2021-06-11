Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY Counter is
GENERIC (n: integer :=6);
port(
RST : in std_logic;
CLK : in std_logic;
Address : out std_logic_vector(n-1 downto 0)
);
end ENTITY;

Architecture my_Counter of Counter is
Begin
PROCESS(CLK)
VARIABLE count : INTEGER RANGE 0 TO 64 := 0;
BEGIN 
IF(RST = '1') then
Address <= (OTHERS=> '0');
count :=0;
ELSIF (rising_edge(CLK)) THEN
IF(count = 64) THEN
count := 0;
END IF;
Address <= std_logic_vector(to_unsigned(count,n));
count := count+1;
END IF;
END PROCESS;
end Architecture;