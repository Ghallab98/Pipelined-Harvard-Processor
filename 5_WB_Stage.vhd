LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY WB_Stage IS
	PORT(
		clk: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		ControlSignals_in : in std_logic_vector(20 downto 0);
		Memory_Data_in : in std_logic_vector(31 downto 0);
		ALU_OUTPUT_in : in std_logic_vector(31 downto 0);
		RR1_in : in std_logic_vector(2 downto 0);
		OUT_PORT_in : in std_logic_vector(31 downto 0);
		----------------------------------------------
		ControlSignals_out : out std_logic_vector(20 downto 0);
		WB_Data : out std_logic_vector(31 downto 0);
		RR1_out : out std_logic_vector(2 downto 0);
		OUT_PORT_out : out std_logic_vector(31 downto 0)
	);
END ENTITY WB_Stage;

Architecture WB_Stage_arch of WB_Stage is
COMPONENT MUX_2x1 IS
	generic(
		n : integer := 32
	);	
	PORT( 
		in0:  IN  std_logic_vector (n-1 DOWNTO 0);
		in1:  IN  std_logic_vector (n-1 DOWNTO 0);
		sel:  IN  std_logic;
		outm: OUT std_logic_vector (n-1 DOWNTO 0)
	);
END COMPONENT;
signal WB_Data_temp : std_logic_vector(31 downto 0);
Begin
	mux_inst : MUX_2x1 generic map(32) PORT MAP(Memory_Data_in, ALU_OUTPUT_in, ControlSignals_in(14), WB_Data_temp);
	WB_Data <= WB_Data_temp;
	RR1_out <= RR1_in;
	OUT_PORT_out <= OUT_PORT_in;
	ControlSignals_out <= ControlSignals_in;
end Architecture;