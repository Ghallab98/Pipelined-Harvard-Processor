LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY EX_MEM_buffer is
	port(
		CLK : in std_logic;
		ControlSignals_in : in std_logic_vector(20 downto 0);
		PC_next_in : in std_logic_vector(31 downto 0);
		ALU_OUTPUT_in : in std_logic_vector(31 downto 0);
		RD1_in : in std_logic_vector(31 downto 0);
		RR1_in : in std_logic_vector(2 downto 0);
		OUT_PORT_in : in std_logic_vector(31 downto 0);
		
		ControlSignals_out : out std_logic_vector(20 downto 0);
		PC_next_out : out std_logic_vector(31 downto 0);
		ALU_OUTPUT_out : out std_logic_vector(31 downto 0);
		RD1_out : out std_logic_vector(31 downto 0);
		RR1_out : out std_logic_vector(2 downto 0);
		OUT_PORT_out : out std_logic_vector(31 downto 0)
	);
END EX_MEM_buffer;

ARCHITECTURE EX_MEM_buffer_arch OF EX_MEM_buffer IS
BEGIN
	PROCESS(CLK)
	BEGIN
		IF rising_edge(CLK) THEN
			ControlSignals_out <= ControlSignals_in;
			PC_next_out <= PC_next_in;
			ALU_OUTPUT_out <= ALU_OUTPUT_in;
			RD1_out <= RD1_in;
			RR1_out <= RR1_in;
			OUT_PORT_out <= OUT_PORT_in;
		END IF;
	END PROCESS;
END ARCHITECTURE;