LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY InstructionMemory IS
PORT (	
       PC:          IN  std_logic_vector(19 DOWNTO 0);  
       Instruction: OUT std_logic_vector(15 DOWNTO 0);
       clk:         IN  std_logic
      );
END InstructionMemory;

ARCHITECTURE InstMemArchi OF InstructionMemory IS
  
COMPONENT instructionRam IS
	GENERIC(
	  DataWidth    : INTEGER := 16;
	  AddressWidth : INTEGER := 20
	  );
	PORT(
		clk     	: IN  std_logic;
		address 	: IN  std_logic_vector(AddressWidth-1 DOWNTO 0);
		writeEnable	: IN std_logic;
		datain 		: IN  std_logic_vector(DataWidth-1 DOWNTO 0);
		dataout		: OUT std_logic_vector(DataWidth-1 DOWNTO 0)
		);
  END COMPONENT;

  SIGNAL R_we:    std_logic;
  SIGNAL R_Din:  std_logic_vector(15 DOWNTO 0);
  SIGNAL R_Dout: std_logic_vector(15 DOWNTO 0);
    
BEGIN
  
  im_RAM: instructionRam PORT MAP (clk,PC,R_we,R_Din,R_Dout);
  
  R_we <= '0';
  R_Din <= (others => '0');
  Instruction <= R_Dout; 

END InstMemArchi;     