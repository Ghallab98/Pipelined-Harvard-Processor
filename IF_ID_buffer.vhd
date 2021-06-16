LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY IF_ID_buffer is
	port(
		CLK : in std_logic;
		CU_NOP_signal : in std_logic;
		Hazard_Detection_Signal : in std_logic;
		PC_next_in : in std_logic_vector(31 downto 0);
		instruction_in : in std_logic_vector(15 downto 0);
		PC_next_out : out std_logic_vector(31 downto 0);
		instruction_out : out std_logic_vector(15 downto 0);
		IN_PORT_in : in std_logic_vector(31 downto 0);
		IN_PORT_out : out std_logic_vector(31 downto 0)
	);
END ENTITY;

ARCHITECTURE IF_ID_buffer_arch OF IF_ID_buffer IS
BEGIN
	PROCESS(CLK)
		VARIABLE NOP_COUNT : integer := 0;
	BEGIN
		IF (Hazard_Detection_Signal = '1' or CU_NOP_signal = '1') and NOP_COUNT = 0 THEN
			NOP_COUNT := 1;
			IF rising_edge(CLK) THEN
				PC_next_out <= (OTHERS=>'Z');
				instruction_out <= (OTHERS=>'0');
			END IF;
		else 
			NOP_COUNT := 0;
			IF rising_edge(CLK) THEN
				PC_next_out <= PC_next_in;
				instruction_out <= instruction_in;
				IN_PORT_out <= IN_PORT_in;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;