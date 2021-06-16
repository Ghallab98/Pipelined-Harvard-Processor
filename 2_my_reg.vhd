LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY my_register IS
GENERIC ( n : integer := 32);
PORT( 
Clk,Rst : IN std_logic;
enable : in std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0)
);
END entity;

ARCHITECTURE a_my_register OF my_register IS
BEGIN
	PROCESS (Clk,Rst)
	BEGIN
		IF Rst = '1' THEN
			q <= (OTHERS=>'0');
		ELSIF falling_edge(Clk) THEN
			if (enable = '1') then 
				q <= d;
			end if; 
		END IF;
	END PROCESS;
END architecture;

