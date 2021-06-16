LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


Entity ForwardingUnit is 
	port (  
		
		RegSrc		: in std_logic_vector (2 downto 0);	-- first register source (to enter excute stage)
		RegDst		: in std_logic_vector (2 downto 0);	-- second register source (to enter excute stage)
		RegDst_ExMem	: in std_logic_vector (2 downto 0);	-- address of register that is in memory stage   
		RegDst_MemWb	: in std_logic_vector (2 downto 0);	-- address of register that is in write back stage 
					
		RegWB_ExMem  	: in std_logic;		-- write back signal to write on the registers from memory stage  (using calculated output)
		RegWB_MemWB 	: in std_logic;		-- write back signal to write on the registers from write back stage using calculated output)
        	In_ExMem	: in std_logic;		-- write back signal to write on the registers from memory stage  (using input port)
		In_MemWB	: in std_logic;		-- write back signal to write on the registers from writeBack stage  (using input port )

		-- 00: Selects original data read from reg.
		-- 01: overwrite ALU data of memory stage
		-- 10: overwrite memory data of wb stage elly tale3 mn mem/wb buffer
		-- 11: takes the value from the in Port 
		FU_1		: out std_logic_vector(1 downto 0);	
		FU_2		: out std_logic_vector(1 downto 0)	
		
		);
end entity ;


architecture FU of ForwardingUnit is
begin
	FU_1 <= 	"01" 	when (RegWB_ExMem = '1' and In_ExMem = '0' and In_MemWB = '0') and (RegDst = RegDst_ExMem or RegDst = RegDst_MemWb)
		else 	"10"	when (RegWB_MemWB = '1' and In_ExMem = '0' and In_MemWB = '0') and (RegDst = RegDst_MemWb or RegDst = RegDst_ExMem)
		else 	"11"	when (In_ExMem = '1' or In_MemWB = '1')and (RegWB_ExMem = '1' or RegWB_MemWB = '1')  and (RegDst = RegDst_ExMem or RegDst = RegDst_MemWb)
		else    "00"    when not (
									((RegWB_ExMem = '1' and In_ExMem = '0' and In_MemWB = '0') and (RegDst = RegDst_ExMem or RegDst = RegDst_MemWb)) and
									((RegWB_MemWB = '1' and In_ExMem = '0' and In_MemWB = '0') and (RegDst = RegDst_MemWb or RegDst = RegDst_ExMem)) and
									((In_ExMem = '1' or In_MemWB = '1')and (RegWB_ExMem = '1' or RegWB_MemWB = '1')  and (RegDst = RegDst_ExMem or RegDst = RegDst_MemWb))
								 )
		else 	"XX";
		
		

	FU_2 <= 	"01" 	when ((RegWB_ExMem = '1' and In_ExMem = '0' and In_MemWB = '0') and ( RegSrc = RegDst_ExMem or RegSrc = RegDst_MemWb))
		else 	"10"	when ((RegWB_MemWB = '1' and In_ExMem = '0' and In_MemWB = '0') and ( RegSrc = RegDst_ExMem or RegSrc = RegDst_MemWb))
		else 	"11"	when (In_ExMem = '1' or In_MemWB = '1')and (RegWB_ExMem = '1' or RegWB_MemWB = '1') and (RegSrc = RegDst_ExMem or RegSrc = RegDst_MemWb)
		else 	"00";
		



end FU;
