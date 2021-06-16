LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY IF_Stage IS
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
    Instruction		:OUT std_logic_vector(15 downto 0);
	IN_PORT_in : in std_logic_vector(31 downto 0);
	IN_PORT_out : out std_logic_vector(31 downto 0);
	Immediate_Signal : in std_logic
    );
END  IF_Stage;

ARCHITECTURE IF_Archi OF IF_Stage IS

Component PC_adder is
	GENERIC (n: integer :=32);
	port(
		PC_Address 	: in std_logic_vector(n-1 downto 0);
		PC_next_Address : out std_logic_vector(n-1 downto 0)
	 );
end Component;

Component PC_controlUnit is 
	generic(n : integer := 32 );
	port(
		clk 			: in std_logic;
		rst 			: in std_logic;
		CU_call_signal	 	: in std_logic;
		CU_PC_eq_PC_signal 	: in std_logic;
		CU_branch_signal 	: in std_logic;
		CU_Ret_signal 		: in std_logic;

		PC_next			: in std_logic_vector (n-1 downto 0);
		PC_eq_PC		: in std_logic_vector (n-1 downto 0);
		PC_rgst			: in std_logic_vector (n-1 downto 0);
		PC_wb			: in std_logic_vector (n-1 downto 0);

		PC_out			: out std_logic_vector (n-1 downto 0);
		Immediate_Signal : in std_logic;
		PC_adder2_out : in std_logic_vector(31 downto 0)
	);
end Component;


Component PC_Register is 
	generic(n : integer := 32 );
	port(
		   clk : in std_logic;
		   d : in std_logic_vector(n-1 downto 0);
		   q : out std_logic_vector(n-1 downto 0)
	);
end Component;

Component instruction_Ram IS
	GENERIC(
	  DataWidth    : INTEGER := 16;
	  AddressWidth : INTEGER := 32
	  );
	PORT(
		address 	: IN  std_logic_vector(AddressWidth-1 DOWNTO 0);
		dataout		: OUT std_logic_vector(DataWidth-1 DOWNTO 0)
		);
END Component;

signal PC_reg_in,PC_reg_out, PC_adder_out, PC_adder2_out	:	std_logic_vector(31 DOWNTO 0); 
SIGNAL ImemOut					:   	std_logic_vector(15 DOWNTO 0);
BEGIN 
  


	PC_CU 	: PC_controlUnit GENERIC MAP (32) PORT MAP (clk,rst,CU_call_signal,CU_PC_eq_PC_signal,CU_branch_signal,CU_Ret_signal,PC_adder_out,PC_reg_out,rgst,wb,PC_reg_in, Immediate_Signal,PC_adder2_out);
	pcReg	: PC_Register GENERIC MAP (32) PORT MAP(clk,PC_reg_in,PC_reg_out);
	adder	: PC_adder GENERIC MAP (32) PORT MAP (PC_reg_out,PC_adder_out);
	adder2  : PC_adder GENERIC MAP (32) PORT MAP (PC_adder_out, PC_adder2_out);
	Ins_mem	: instruction_Ram PORT MAP (PC_reg_out,ImemOut);
	PC_next <= PC_adder_out;
	Instruction <= ImemOut;
	IN_PORT_out <= IN_PORT_in;
END IF_Archi;  
    
   
  
  


