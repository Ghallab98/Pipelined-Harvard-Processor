LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY OUT_PORT is
	port(
		OUT_PORT_SIGNAL : in std_logic;
		OUT_PORT_in : in std_logic_vector(31 downto 0);
		OUT_PORT_out : out std_logic_vector(31 downto 0);
		);
END ENTITY;

Architecture OUT_PORT_Arch of OUT_PORT is
BEGIN
	OUT_PORT_out <= OUT_PORT_in when OUT_PORT_SIGNAL = '1'
			else	(OTHERS=>'Z');