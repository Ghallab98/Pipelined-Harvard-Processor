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
		registerExecute: in std_logic_vector(2 downto 0);
		isExecuteLoad: in std_logic;
		PC_eq_PC_signal : out std_logic;
		NOP_Signal : out std_logic;
		RD1 : out std_logic_vector(31 downto 0);
		RD2 : out std_logic_vector(31 downto 0);
		RR1 : out std_logic_vector(2 downto 0);
		RR2 : out std_logic_vector(2 downto 0);
		ImmediateValue : out std_logic_vector(31 downto 0);
		OUT_PORT_BUS : out std_logic_vector(31 downto 0);
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
COMPONENT EX_Stage is
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
		
		RR2_FROM_Decode, RR1_FROM_Decode, RR1_FROM_MEM, RR1_FROM_WB : in std_logic_vector(2 downto 0);
		WB_SIGNAL_MEM, WB_SIGNAL_WB, IN_PORT_SIGNAL_MEM, IN_PORT_SIGNAL_WB : in std_logic;
		
		ControlSignals_out : out std_logic_vector(20 downto 0);
		PC_next_out : out std_logic_vector(31 downto 0);
		ALU_OutPut : out std_logic_vector(31 downto 0);
		RD1_out : out std_logic_vector(31 downto 0);
		RR1_out : out std_logic_vector(2 downto 0);
		CCR_out : out std_logic_vector(2 downto 0);
		OUT_PORT_out : out std_logic_vector(31 downto 0)
	);
END COMPONENT;
COMPONENT EX_MEM_buffer is
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
END COMPONENT;
COMPONENT Mem_Stage IS
	PORT(
		clk: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		controlSignal_IN: IN STD_LOGIC_VECTOR(20 DOWNTO 0);
		PC_NEXT_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_OUTPUT_in: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RD1_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RR1_IN: IN std_logic_vector(2 downto 0);
		OUT_PORT_IN: IN std_logic_vector(31 downto 0);
		----------------------------------------------
		ControlSignals_out : out std_logic_vector(20 downto 0);
		ALU_OUTPUT_out : out std_logic_vector(31 downto 0);
		RR1_out : out std_logic_vector(2 downto 0);
		memory_data_out: out std_logic_vector(31 downto 0);
		write_back_signal_out: out std_logic;
		IN_PORT_SIGNAL_OUT: out std_logic;
		OUT_PORT_out : out std_logic_vector(31 downto 0)
	);
END COMPONENT ;
COMPONENT MEM_WB_buffer is
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
END COMPONENT;
COMPONENT WB_Stage IS
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
END COMPONENT;
signal CU_branch_signal, CU_Ret_signal : std_logic;
signal PC_next_Fetch, PC_next_Decode, PC_next_Execute, PC_next_Mem, PC_next_To_Mem, PC_next_WB : std_logic_vector(31 downto 0);
signal instruction_Fetch, instruction_Decode : std_logic_vector(15 downto 0);

signal Memory_Read_Enable : std_logic;
signal Write_Address_EX_temp : std_logic_vector(2 downto 0);
signal CCR_temp : std_logic_vector(2 downto 0);
signal RD1_temp, RD2_temp, RD1_EX, RD2_EX, RD1_MEM, RD1_To_MEM, ImmediateValue_temp, OUT_PORT_temp, ImmediateValue_EX, OUT_PORT_EX, OUT_PORT_MEM, 
	   OUT_PORT_To_MEM, OUT_PORT_WB, OUT_PORT_TO_WB, OUT_PORT_Final, ALU_OutPut_MEM, ALU_OutPut_To_MEM, ALU_OUTPUT_TO_WB, RD1_WB : std_logic_vector(31 downto 0);
signal RR1_temp, RR2_temp, RR1_EX, RR2_EX, RR1_MEM, RR1_To_MEM, RR1_WB, RR1_Final, RR1_TO_WB : std_logic_vector(2 downto 0);
signal ControlSignals_FROM_ID, ControlSignals_OUT_EX, ControlSignals_OUT_MEM, ControlSignals_TO_MEM, 
	   ControlSignals_OUT_WB, ControlSignals_OUT_Final, ControlSignals_TO_WB : std_logic_vector(20 downto 0);
signal Hazard_To_PC, Hazard_To_Buffer, WB_Signal_OUT_FU, IN_PORT_SIGNAL_OUT_FU : std_logic;
signal WriteBackOutput, ALU_OUTPUT_FROM_MEMORY, ALU_OUTPUT_WB, Memory_Data_WB, WB_Data_Final, Memory_Data_TO_WB : std_logic_vector(31 downto 0);

Begin
	IF_inst : IF_Stage PORT MAP(CLK, RESET, ControlSignals_FROM_ID(2), Hazard_To_PC, CU_branch_signal, ControlSignals_OUT_Final(1), RD1_temp, WB_Data_Final, PC_next_Fetch, 
								instruction_Fetch);
								
	IF_ID_buffer_inst : IF_ID_buffer PORT MAP(CLK, ControlSignals_FROM_ID(0), Hazard_To_Buffer, PC_next_Fetch, instruction_Fetch, 
											  PC_next_Decode, instruction_Decode);
											  
	ID_inst : ID_Stage PORT MAP(CLK, RESET, instruction_Decode, PC_next_Decode, ControlSignals_OUT_Final(12), 
								RR1_Final, WB_Data_Final, Memory_Read_Enable, 
								Write_Address_EX_temp, CCR_temp, RR1_EX, ControlSignals_OUT_EX(16), Hazard_To_PC, Hazard_To_Buffer, RD1_temp, RD2_temp, RR1_temp, RR2_temp, 
								ImmediateValue_temp, OUT_PORT_temp, ControlSignals_FROM_ID);
								
	ID_EX_buffer_inst : ID_EX_buffer PORT MAP(CLK, ControlSignals_FROM_ID, PC_next_Decode, RD1_temp, RD2_temp, RR1_temp, RR2_temp, ImmediateValue_temp, OUT_PORT_temp,
								ControlSignals_OUT_EX, PC_next_Execute, RD1_EX, RD2_EX, RR1_EX, RR2_EX, ImmediateValue_EX, OUT_PORT_EX);
								--TODO: IN PORT in execution stage must come From the begining
	EX_inst : EX_Stage PORT MAP(CLK, RESET, ControlSignals_OUT_EX, PC_next_Execute, RD1_EX, RD2_EX, RR1_EX, RR2_EX, ImmediateValue_EX, IN_PORT, OUT_PORT_EX,
								WriteBackOutput, ALU_OUTPUT_FROM_MEMORY, RR2_temp, RR1_temp,  RR1_WB, RR1_Final, WB_Signal_OUT_FU, 
								ControlSignals_OUT_Final(13), IN_PORT_SIGNAL_OUT_FU, ControlSignals_OUT_Final(11),
								ControlSignals_OUT_MEM, PC_next_MEM, ALU_OutPut_MEM, RD1_MEM, RR1_MEM, 
								CCR_temp, OUT_PORT_MEM);
								
	EX_MEM_buffer_inst : EX_MEM_buffer PORT MAP(CLK, ControlSignals_OUT_MEM, PC_next_MEM, ALU_OutPut_MEM, RD1_MEM, RR1_MEM, OUT_PORT_MEM, 
											ControlSignals_TO_MEM, PC_next_To_Mem, ALU_OutPut_To_MEM, RD1_To_MEM, RR1_To_MEM, OUT_PORT_To_MEM);
	
	MEM_inst : Mem_Stage PORT MAP(CLK, RESET, ControlSignals_TO_MEM, PC_next_To_Mem, ALU_OutPut_To_MEM, RD1_To_MEM, RR1_To_MEM, OUT_PORT_To_MEM,
								  ControlSignals_OUT_WB, ALU_OUTPUT_WB, RR1_WB, Memory_Data_WB, WB_Signal_OUT_FU, 
								  IN_PORT_SIGNAL_OUT_FU, OUT_PORT_WB);
								  
	MEM_WB_buffer_inst : MEM_WB_buffer PORT MAP(CLK, ControlSignals_OUT_WB, Memory_Data_WB, ALU_OUTPUT_WB, RR1_WB, OUT_PORT_WB, 
												ControlSignals_TO_WB, Memory_Data_TO_WB, ALU_OUTPUT_TO_WB, RR1_TO_WB, OUT_PORT_TO_WB);
												
	WB_inst  : WB_Stage PORT MAP(CLK, RESET, ControlSignals_TO_WB, Memory_Data_TO_WB, ALU_OUTPUT_TO_WB, RR1_TO_WB, OUT_PORT_TO_WB,
								 ControlSignals_OUT_Final, WB_Data_Final, RR1_Final, OUT_PORT_Final);
	OUT_PORT <= OUT_PORT_Final;
END Architecture;