Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity Ex_stage is 
	GENERIC (n : integer := 32);
	port(
		clk			: in std_logic;
		Rdst			: in std_logic_vector (n-1 downto 0);
		Rsrc			: in std_logic_vector (n-1 downto 0 );
		opCode 			: in std_logic_vector (3 downto 0);
		shiftImmValue		: in std_logic_vector (4 downto 0 );
		immValue		: in std_logic_vector (n-1 downto 0 );
		AluSrc_Select		: in std_logic_vector (1 downto 0 );
		FU_1			: in std_logic_vector (1 downto 0 );
		FU_2			: in std_logic_vector (1 downto 0 );
		In_port 		: in std_logic_vector (n-1 downto 0);
		WriteBackOutput 	: in std_logic_vector (n-1 downto 0);
		EX_buffeur_output	: in std_logic_vector (n-1 downto 0);

		Rout			: out std_logic_vector (n-1 downto 0);
		CarryFlagOut		: out std_logic;
		ZeroFlagOut		: out std_logic;
		NegFlagOut		: out std_logic

	);

end entity;

ARCHITECTURE ex OF Ex_stage IS


component ALU is 
	port(
		R1		: in std_logic_vector (n-1 downto 0);
		R2		: in std_logic_vector (n-1 downto 0 );
		sel 		: in std_logic_vector (3 downto 0);
		immValue	: in std_logic_vector (4 downto 0 );
		Rout		: out std_logic_vector (n-1 downto 0);
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
		in0:  IN  std_logic_vector (n-1 DOWNTO 0);
		in1:  IN  std_logic_vector (n-1 DOWNTO 0);
		in2:  IN  std_logic_vector (n-1 DOWNTO 0);
		in3:  IN  std_logic_vector (n-1 DOWNTO 0);
		sel:  IN  std_logic_vector (1 DOWNTO 0);
		outm: OUT std_logic_vector (n-1 DOWNTO 0)
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

signal empty, Rsrc_plus_immValue, mux_1_Output 		: std_logic_vector (n-1 downto 0);
signal ALU_Mux_1_Output,ALU_Mux_2_Output,ALU_Output	: std_logic_vector (n-1 downto 0);
signal AlU_C , ALU_Z , ALU_N , CCR_C , CCR_Z , CCR_N	: STD_LOGIC;
signal temp : unsigned (n-1 downto 0); 

begin 
	empty <= (OTHERS=>'Z');

	temp <= unsigned(Rdst) + unsigned(immValue);
	Rsrc_plus_immValue <= std_logic_vector(temp);
	

	mux1	: MUX_4x1 generic map (n) 
			port map (	Rsrc,
					immValue,
					Rsrc_plus_immValue,	
					empty,
					AluSrc_Select,
					mux_1_Output
				);
	AlUmux1	: MUX_4x1 generic map (n) 
			port map (
					Rdst,
					EX_buffeur_output,
					WriteBackOutput,
					In_port,
					FU_1,
					ALU_Mux_1_Output
				);
	ALUmux2	: MUX_4x1 generic map (n)
			 port map (
					mux_1_Output,
					EX_buffeur_output,
					WriteBackOutput,
					In_port,
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

	
	alu_block: ALU generic map (n) 
			PORT MAP (
					ALU_Mux_1_Output,
					ALU_Mux_2_Output,
					opCode,
					shiftImmValue,
					ALU_Output,
					CCR_C,
					CCR_Z,
					CCR_N,
					ALU_C,
					ALU_Z,
					ALU_N											
				); 

	Rout 		<= AlU_Output ;
	CarryFlagOut	<= ALU_C;
	ZeroFlagOut	<= ALU_Z;
	NegFlagOut	<= ALU_N;

end ex;
