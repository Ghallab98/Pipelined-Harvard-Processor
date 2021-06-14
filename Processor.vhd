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
		--TODO: Hazard Detection Signal
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
		OUT_PORT : out std_logic_vector(31 downto 0)
		--TODO: ControlUnit OUTPUTS
	);
END COMPONENT;
Begin

END Architecture;