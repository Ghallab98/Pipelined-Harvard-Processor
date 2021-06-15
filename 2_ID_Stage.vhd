LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY ID_Stage is
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
		RD1 : out std_logic_vector(31 downto 0);
		RD2 : out std_logic_vector(31 downto 0);
		RR1 : out std_logic_vector(2 downto 0);
		RR2 : out std_logic_vector(2 downto 0);
		ImmediateValue : out std_logic_vector(31 downto 0);
		OUT_PORT_BUS : out std_logic_vector(31 downto 0);
		ControlSignals : out std_logic_vector(20 downto 0)
	);
END ENTITY ID_Stage;

Architecture ID_Stage_arch of ID_Stage is
COMPONENT register_file IS
	GENERIC ( n : integer := 32);
	PORT( 
		Clk,Rst 	: in std_logic;
		read_address_1 	: in std_logic_vector (2 downto 0);
		read_address_2 	: in std_logic_vector (2 downto 0);
		write_enable 	: in std_logic;
		write_address 	: in std_logic_vector (2 downto 0);
		write_databus	: in std_logic_vector (n-1 downto 0);
		databus_1 	: out std_logic_vector (n-1 downto 0);
		databus_2 	: out std_logic_vector (n-1 downto 0)
	);
END COMPONENT;
COMPONENT signExtend is 
	port(
		a: in std_logic_vector (15 downto 0);
		f: out std_logic_vector (31 downto 0)
	);
end COMPONENT;
COMPONENT OUT_PORT is
	port(
		OUT_PORT_SIGNAL : in std_logic;
		OUT_PORT_in : in std_logic_vector(31 downto 0);
		OUT_PORT_out : out std_logic_vector(31 downto 0)
	);
END COMPONENT;
COMPONENT ControlUnit is
	port(
		opCode: in std_logic_vector(4 downto 0);
		controlOut : out std_logic_vector(20 downto 0)
	);
end COMPONENT;
COMPONENT HazardDetectionUnit IS
	PORT(
		registerDecode1,registerDecode2,registerExecute: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		isExecuteLoad: IN STD_LOGIC;
		fetchDecodeNOP,programCounterMUX: OUT STD_LOGIC 
	);
END COMPONENT;
signal Rdst : std_logic_vector(31 downto 0);
signal Rsrc : std_logic_vector(31 downto 0);
signal sign_extend_out : std_logic_vector(31 downto 0);
signal ControlSignals_temp : std_logic_vector(20 downto 0);
signal OUT_PORT_temp : std_logic_vector(31 downto 0);
--20 to 17 ALU Control, 16 Memory Read, 15 Memory Write, 14 MemToReg, 13 WB, 12 Write_Enable RegFile, 11 IN.Port Signal, 10 Out.Port Signal(to Out.Port Block), 
--9 to 8 ALUSrc, 7 set/clr, 6 enable C, 5 Memory-Address-Selector(Stack), 4 enable S, 3 push/pop, 2 Call(Back to PC_CU & in Buffer), 1 Ret, 0 NOP in IF/ID buffer
BEGIN
	Control_Unit : ControlUnit PORT MAP(instruction(15 downto 11), ControlSignals_temp);
	RegisterFile : register_file GENERIC MAP (32) PORT MAP(CLK,RST,instruction(10 downto 8),instruction(7 downto 5),Write_Enable,Write_Address_WB,Write_Data_WB,Rdst,Rsrc);
	OUT_PORT_inst : OUT_PORT PORT MAP(instruction(10), Rdst, OUT_PORT_temp);
	Sign_Extend : signExtend PORT MAP(instruction, sign_extend_out);
	HDU: HazardDetectionUnit PORT MAP(instruction(10 downto 8),instruction(7 downto 5),registerExecute,isExecuteLoad);
	RD1 <= Rdst;
	RD2 <= Rsrc;
	RR1 <= instruction(10 downto 8);
	RR2 <= instruction(7 downto 5);
	ImmediateValue <= sign_extend_out;
	OUT_PORT_BUS <= OUT_PORT_temp;
	ControlSignals <= ControlSignals_temp;
end Architecture;