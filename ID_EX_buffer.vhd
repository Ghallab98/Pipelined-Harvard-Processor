LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY ID_EX_buffer is
	port(
		CLK : in std_logic;
		ControlSignals_in : in std_logic_vector(20 downto 0);
		PC_next_in : in std_logic_vector(31 downto 0);
		RD1_in : in std_logic_vector(31 downto 0);
		RD2_in : in std_logic_vector(31 downto 0);
		RR1_in : in std_logic_vector(2 downto 0);
		RR2_in : in std_logic_vector(2 downto 0);
		ImmediateValue_in : in std_logic_vector(31 downto 0);
		OUT_PORT_in : in std_logic_vector(31 downto 0);
		
		ControlSignals_out : out std_logic_vector(20 downto 0);
		PC_next_out : out std_logic_vector(31 downto 0);
		RD1_out : out std_logic_vector(31 downto 0);
		RD2_out : out std_logic_vector(31 downto 0);
		RR1_out : out std_logic_vector(2 downto 0);
		RR2_out : out std_logic_vector(2 downto 0);
		ImmediateValue_out : out std_logic_vector(31 downto 0);
		OUT_PORT_out : out std_logic_vector(31 downto 0);
		IN_PORT_in : in std_logic_vector(31 downto 0);
		IN_PORT_out : out std_logic_vector(31 downto 0)
	);
END ENTITY;

ARCHITECTURE ID_EX_buffer_arch OF ID_EX_buffer IS
BEGIN
	PROCESS(CLK)
	BEGIN
		IF rising_edge(CLK) THEN
			ControlSignals_out <= ControlSignals_in;
			PC_next_out <= PC_next_in;
			RD1_out <= RD1_in;
			RD2_out <= RD2_in;
			RR1_out <= RR1_in;
			RR2_out <= RR2_in;
			ImmediateValue_out <= ImmediateValue_in;
			OUT_PORT_out <= OUT_PORT_in;
			IN_PORT_out <= IN_PORT_in;
		END IF;
	END PROCESS;
END ARCHITECTURE;