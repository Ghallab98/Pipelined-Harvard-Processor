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

       	Instruction		:OUT std_logic_vector(15 downto 0) 
       );
END  IF_Stage;

ARCHITECTURE IF_Archi OF IF_Stage IS

Component PC_adder is
	GENERIC (n: integer :=20);
	port(
		CLK 		: in std_logic;
		PC_Address 	: in std_logic_vector(n-1 downto 0);
		PC_next_Address : out std_logic_vector(n-1 downto 0)
	 );
end Component;

Component PC_controlUnit is 
	generic(n : integer := 20 );
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

		PC_out			: out std_logic_vector (n-1 downto 0)
	);
end Component;


Component reg is 
	generic(n : integer := 20 );
	port(
		   clk : in std_logic;
		   reset : in std_logic;
		   en : in std_logic;
		   d : in std_logic_vector(n-1 downto 0);
		   q : out std_logic_vector(n-1 downto 0)
	);
end component;

Component InstructionMemory IS
PORT (	
       PC:          IN  std_logic_vector(19 DOWNTO 0);  
       Instruction: OUT std_logic_vector(15 DOWNTO 0);
       clk:         IN  std_logic
      );
END Component;

signal en 					: 	std_logic ;	
signal PC_reg_in,PC_reg_out, PC_adder_out	:	std_logic_vector(19 DOWNTO 0); 
SIGNAL ImemOut					:   	std_logic_vector(15 DOWNTO 0);
BEGIN 
  


	PC_CU 	: PC_controlUnit GENERIC MAP (20) PORT MAP (clk,rst,CU_call_signal,CU_PC_eq_PC_signal,CU_branch_signal,CU_Ret_signal,PC_adder_out,PC_reg_out,rgst(19 downto 0),wb(19 downto 0),PC_reg_in );
	pcReg	: reg GENERIC MAP (20) PORT MAP(clk,rst,   en   ,PC_reg_in,PC_reg_out);
	adder	: PC_adder GENERIC MAP (20) PORT MAP (clk,PC_reg_out,PC_adder_out);
	Ins_mem	: InstructionMemory PORT MAP (PC_reg_out,ImemOut,clk);
	Instruction <= ImemOut;
  	en <= '1';
END IF_Archi;  
    
   
  
  


