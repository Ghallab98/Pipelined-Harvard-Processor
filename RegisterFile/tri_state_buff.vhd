LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY tri_state_buffer IS
GENERIC ( n : integer := 32);
    PORT(
        my_in  : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        enable : IN STD_LOGIC;
        my_out : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END entity;

ARCHITECTURE my_tri OF tri_state_buffer IS
BEGIN
    process (enable)
	begin
		
		if (enable = '1') then 
			my_out <= my_in;
		else 
			my_out <= (others=> 'Z');
		end if;
	end process;
END architecture;

