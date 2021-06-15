LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY MEM_WB_buffer is
	port(
		CLK : in std_logic;
		ControlSignals_in : in std_logic_vector(20 downto 0);
		Memory_Data_in : in std_logic_vector(31 downto 0);
		ALU_OUTPUT_in : in std_logic_vector(31 downto 0);
		RR1_in : in std_logic_vector(2 downto 0);
		OUT_PORT_in : in std_logic_vector(31 downto 0);
		
		ControlSignals_out : out std_logic_vector(20 downto 0);
		Memory_Data_out : out std_logic_vector(31 downto 0);
		ALU_OUTPUT_out : out std_logic_vector(31 downto 0);
		RR1_out : out std_logic_vector(2 downto 0);
		OUT_PORT_out : out std_logic_vector(31 downto 0)
	);
END MEM_WB_buffer;

Architecture MEM_WB_buffer_arch of MEM_WB_buffer is
Begin
	PROCESS(CLK)
	BEGIN
		IF rising_edge(CLK) THEN
			ControlSignals_out <= ControlSignals_in;
			Memory_Data_out <= Memory_Data_in;
			ALU_OUTPUT_out <= ALU_OUTPUT_in;
			RR1_out <= RR1_in;
			OUT_PORT_out <= OUT_PORT_in;
		END IF;
	END PROCESS;
end Architecture;