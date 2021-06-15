Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY EX_Stage is
	port(
		CLK : in std_logic;
		RST : in std_logic;
		ControlSignals_in : in std_logic_vector(20 downto 0);
		PC_next_in : in std_logic_vector(31 downto 0);
		RD1_in : in std_logic_vector(31 downto 0);
		RD2_in : in std_logic_vector(31 downto 0);
		RR1_in : in std_logic_vector(2 downto 0);
		RR2_in : in std_logic_vector(2 downto 0);
		ImmediateValue_in : in std_logic_vector(31 downto 0);
		IN_PORT_in : in std_logic_vector(31 downto 0);
		OUT_PORT_in : in std_logic_vector(31 downto 0);
		WriteBackOutput : in std_logic_vector(31 downto 0);
		ALU_OUTPUT_FROM_MEMORY : in std_logic_vector(31 downto 0);
		
		ControlSignals_out : out std_logic_vector(20 downto 0);
		PC_next_out : out std_logic_vector(31 downto 0);
		ALU_OutPut : out std_logic_vector(31 downto 0);
		RD1_out : out std_logic_vector(31 downto 0);
		RR1_out : out std_logic_vector(2 downto 0);
		CCR_out : out std_logic_vector(2 downto 0)
	);
END EX_Stage;
Architecture EX_Stage_arch of EX_Stage is
component ALU is 
	port(
		R1		: in std_logic_vector (31 downto 0);
		R2		: in std_logic_vector (31 downto 0 );
		sel 		: in std_logic_vector (3 downto 0);
		immValue	: in std_logic_vector (4 downto 0 );
		Rout		: out std_logic_vector (31 downto 0);
		CF_In		: in std_logic;
		ZF_In		: in std_logic;
		NF_In		: in std_logic;
		CarryFlagOut	: out std_logic;
		ZeroFlagOut	: out std_logic;
		NegFlagOut	: out std_logic
	);
end component;
component MUX_4x1 IS
	PORT( 
		in0:  IN  std_logic_vector (31 DOWNTO 0);
		in1:  IN  std_logic_vector (31 DOWNTO 0);
		in2:  IN  std_logic_vector (31 DOWNTO 0);
		in3:  IN  std_logic_vector (31 DOWNTO 0);
		sel:  IN  std_logic_vector (1 DOWNTO 0);
		outm: OUT std_logic_vector (31 DOWNTO 0)
	);
END component;
component CCR is 
	port(
		clk 		: in std_logic;
		C_ccr_In 	: in std_logic;
		Z_ccr_In 	: in std_logic;
		N_ccr_In 	: in std_logic;
		C_ccr_Out	: out std_logic;
		Z_ccr_Out	: out std_logic;
		N_ccr_Out 	: out std_logic
	);
end component;

signal empty, Rsrc_plus_immValue, mux_1_Output 		: std_logic_vector (31 downto 0);
signal ALU_Mux_1_Output,ALU_Mux_2_Output,ALU_Output_temp	: std_logic_vector (31 downto 0);
signal AlU_C , ALU_Z , ALU_N , CCR_C , CCR_Z , CCR_N	: STD_LOGIC;
signal temp : unsigned (31 downto 0); 
signal CCR_temp : std_logic_vector(2 downto 0);
signal FU_1, FU_2 : std_logic_vector(1 downto 0); --Removed when adding FU

Begin
	empty <= (OTHERS=>'Z');
	
	temp <= unsigned(RD1_in) + unsigned(ImmediateValue_in);
	Rsrc_plus_immValue <= std_logic_vector(temp);
	
	mux1	: MUX_4x1 generic map (32) 
			port map (	
					RD2_in,
					ImmediateValue_in,
					Rsrc_plus_immValue,	
					empty,
					ControlSignals_in(9 downto 8),
					mux_1_Output
				);
	AlUmux1	: MUX_4x1 generic map (32) 
			port map (
					RD1_in,
					ALU_OUTPUT_FROM_MEMORY,
					WriteBackOutput,
					IN_PORT_in,
					FU_1,
					ALU_Mux_1_Output
				);
	ALUmux2	: MUX_4x1 generic map (32)
			 port map (
					mux_1_Output,
					ALU_OUTPUT_FROM_MEMORY,
					WriteBackOutput,
					IN_PORT_in,
					FU_2,
					ALU_Mux_2_Output
				);
	ccr_reg	: CCR 	port map (
					clk,
					ALU_C,
					ALU_Z,
					ALU_N,
					CCR_C,
					CCR_Z,
					CCR_N
				);
	alu_block: ALU generic map (32) 
			PORT MAP (
					ALU_Mux_1_Output,
					ALU_Mux_2_Output,
					ControlSignals_in(20 downto 17),
					ImmediateValue_in(4 downto 0),
					ALU_Output_temp,
					CCR_C,
					CCR_Z,
					CCR_N,
					ALU_C,
					ALU_Z,
					ALU_N											
				); 
	ALU_OutPut <= ALU_Output_temp;
	CCR_out <= CCR_temp;
	ControlSignals_out <= ControlSignals_in;
	PC_next_out <= PC_next_in;
	RD1_out <= RD1_in;
	RR1_out <= RR1_in;
END Architecture;

