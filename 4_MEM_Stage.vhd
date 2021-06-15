LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY Mem_Stage IS
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
END ENTITY Mem_Stage;

ARCHITECTURE Mem_Stage_Arch OF Mem_Stage IS
COMPONENT SPCounter IS
	GENERIC(AddressWidth : INTEGER := 32);
	PORT(
		clk         : IN std_logic;
        rst         : IN std_logic; 
		enable      : IN  std_logic;
		push_pop    : IN  std_logic;   -- 0 for push(-2) 1 for pop(+2)
		adddressSP    : OUT std_logic_vector(AddressWidth-1 DOWNTO 0)
	);
END COMPONENT;
COMPONENT GenRam IS
GENERIC(DataWidth:INTEGER := 16; AddressWidth : INTEGER := 32;AddressSpace : INTEGER := 1048575);
	PORT(
		clk     : IN  std_logic;
		we      : IN  std_logic;
        	re      : IN  std_logic;
		address : IN  std_logic_vector(AddressWidth-1 DOWNTO 0);
		datain : IN  std_logic_vector(DataWidth-1 DOWNTO 0);
		dataout: OUT std_logic_vector(DataWidth-1 DOWNTO 0)
	);
END COMPONENT;
COMPONENT MUX_2x1 IS
generic(n : integer := 32);	
	PORT( 
		in0:  IN  std_logic_vector (n-1 DOWNTO 0);
		in1:  IN  std_logic_vector (n-1 DOWNTO 0);
		sel:  IN  std_logic;
		outm: OUT std_logic_vector (n-1 DOWNTO 0)
	);
END COMPONENT;
SIGNAL SPCounterOutput,MemMuxOutput1,MemMuxOutput2,MemoryOutput: STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
	SPCounterDebug: SPCounter PORT MAP(clk,reset,controlSignal_IN(3),controlSignal_IN(4),SPCounterOutput);
	MemMux1: MUX_2x1 PORT MAP(SPCounterOutput,ALU_OUTPUT_in,controlSignal_IN(5),MemMuxOutput1);
	MemMux2: MUX_2x1 PORT MAP(PC_NEXT_IN,RD1_IN,controlSignal_IN(2),MemMuxOutput2);
	MemDebug: GenRam PORT MAP(clk,controlSignal_IN(15),controlSignal_IN(16),MemMuxOutput1,MemMuxOutput2,MemoryOutput);
	
	ALU_OUTPUT_out <= ALU_OUTPUT_in;
	RR1_out <= RR1_IN;
	ControlSignals_out <= controlSignal_IN;
	memory_data_out <= MemoryOutput;
	OUT_PORT_out <= OUT_PORT_IN;
	IN_PORT_SIGNAL_OUT <= controlSignal_IN(11);
	write_back_signal_out <= controlSignal_IN(13);
END ARCHITECTURE;