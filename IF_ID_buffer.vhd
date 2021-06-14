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
		instruction_out : out std_logic_vector(15 downto 0)
	);
END ENTITY;

ARCHITECTURE IF_ID_buffer_arch OF IF_ID_buffer IS
BEGIN
	PROCESS(CLK)
	BEGIN
		IF Hazard_Detection_Signal = '0' and CU_NOP_signal = '0'
			IF rising_edge(CLK) THEN
				PC_next_out <= PC_next_in;
				instruction_out <= instruction_in;
			END IF;
		else 
			IF rising_edge(CLK) THEN
				PC_next_out <= (OTHERS=>'Z');
				instruction_out <= (OTHERS=>'Z');
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;