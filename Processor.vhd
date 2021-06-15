LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY Processor is
	port(
		CLK : in std_logic;
		IN_PORT : in std_logic_vector(31 downto 0);
		OUT_PORT : out std_logic_vector(31 downto 0);
		RESET : in std_logic
	);
END ENTITY;
Architecture Processor_arch of Processor is
COMPONENT IF_Stage IS
PORT (
	clk			: IN std_logic;
	rst 			: in std_logic;
	CU_call_signal	 	: in std_logic;
	CU_PC_eq_PC_signal 	: in std_logic;
	CU_branch_signal 	: in std_logic;
	CU_Ret_signal 		: in std_logic;

	rgst			: in std_logic_vector (31 downto 0);
	wb			: in std_logic_vector (31 downto 0);
	
	PC_next  	: out std_logic_vector(31 downto 0);
    Instruction		:OUT std_logic_vector(15 downto 0) 
    );
END  COMPONENT;

COMPONENT IF_ID_buffer is
	port(
		CLK : in std_logic;
		CU_NOP_signal : in std_logic;
		Hazard_Detection_Signal : in std_logic;
		PC_next_in : in std_logic_vector(31 downto 0);
		instruction_in : in std_logic_vector(15 downto 0);
		PC_next_out : out std_logic_vector(31 downto 0);
		instruction_out : out std_logic_vector(15 downto 0)
	);
END COMPONENT;
COMPONENT ID_Stage is
	port(
		CLK : in std_logic;
		RST : in std_logic;
		instruction : in std_logic_vector(15 downto 0); --To break down
		PC_next : in std_logic_vector(31 downto 0);
		Write_Enable : in std_logic; --Reg File
		Write_Address_WB : in std_logic_vector(2 downto 0); --Reg File from WriteBack
		Write_Data_WB : in std_logic_vector(31 downto 0); --Reg File from WriteBack
		Read_Enable : in std_logic; --to Hazard Detection UNIT from Execute Stage
		Write_Address_EX : in std_logic_vector(2 downto 0); --Hazard Detection UNIT from Execute Stage
		CCR : in std_logic_vector(2 downto 0); -- Flags From Execute stage
		
		RD1 : out std_logic_vector(31 downto 0);
		RD2 : out std_logic_vector(31 downto 0);
		RR1 : out std_logic_vector(2 downto 0);
		RR2 : out std_logic_vector(2 downto 0);
		ImmediateValue : out std_logic_vector(31 downto 0);
		OUT_PORT : out std_logic_vector(31 downto 0);
		ControlSignals : out std_logic_vector(20 downto 0)
	);
END COMPONENT;
COMPONENT ID_EX_buffer is
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
		OUT_PORT_out : out std_logic_vector(31 downto 0)
	);
END COMPONENT;
signal CU_call_signal, CU_PC_eq_PC_signal, CU_branch_signal, CU_Ret_signal,Hazard_Detection_Signal_temp : std_logic;
signal rgst, wb, PC_next_Fetch, PC_next_Decode, PC_next_Execute : std_logic_vector(31 downto 0);
signal instruction_Fetch, instruction_Decode : std_logic_vector(15 downto 0);

signal Write_Enable_temp : std_logic;
signal Write_Address_WB_temp : std_logic_vector(2 downto 0);
signal Write_Data_WB_temp : std_logic_vector(31 downto 0);
signal Memory_Read_Enable : std_logic;
signal Write_Address_EX_temp : std_logic_vector(2 downto 0);
signal CCR_temp : std_logic_vector(2 downto 0);
signal RD1_temp, RD2_temp, RD1_EX, RD2_EX ,ImmediateValue_temp, OUT_PORT_temp, ImmediateValue_EX, OUT_PORT_EX : std_logic_vector(31 downto 0);
signal RR1_temp, RR2_temp, RR1_EX, RR2_EX : std_logic_vector(2 downto 0);
signal ControlSignals_temp, ControlSignals_OUT_EX : std_logic_vector(20 downto 0);
Begin
	IF_inst : IF_Stage PORT MAP(CLK, RESET, CU_call_signal, CU_PC_eq_PC_signal, CU_branch_signal, CU_Ret_signal, rgst, wb, PC_next_Fetch, instruction_Fetch);
	IF_ID_buffer_inst : IF_ID_buffer PORT MAP(CLK, ControlSignals_temp(0),Hazard_Detection_Signal_temp , PC_next_Fetch, instruction_Fetch, PC_next_Decode, instruction_Decode);
	ID_inst : ID_Stage PORT MAP(CLK, RESET, instruction_Decode, PC_next_Decode, Write_Enable_temp, 
								Write_Address_WB_temp, Write_Data_WB_temp, Memory_Read_Enable, 
								Write_Address_EX_temp, CCR_temp, RD1_temp, RD2_temp, RR1_temp, RR2_temp, ImmediateValue_temp, OUT_PORT_temp, ControlSignals_temp);
	ID_EX_buffer_inst : ID_EX_buffer PORT MAP(CLK, ControlSignals_temp, PC_next_Decode, RD1_temp, RD2_temp, RR1_temp, RR2_temp, ImmediateValue_temp, OUT_PORT_temp,
								ControlSignals_OUT_EX, PC_next_Execute, RD1_EX, RD2_EX, RR1_EX, RR2_EX, ImmediateValue_EX, OUT_PORT_EX);
END Architecture;