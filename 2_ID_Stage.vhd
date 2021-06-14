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
		
		RD1 : out std_logic_vector(31 downto 0);
		RD2 : out std_logic_vector(31 downto 0);
		RR1 : out std_logic_vector(2 downto 0);
		RR2 : out std_logic_vector(2 downto 0);
		ImmediateValue : out std_logic_vector(31 downto 0);
		OUT_PORT : out std_logic_vector(31 downto 0)
		--TODO: ControlUnit OUTPUTS
	);
END ENTITY;

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

signal Rdst : std_logic_vector(31 downto 0);
signal Rsrc : std_logic_vector(31 downto 0);
signal sign_extend_out : std_logic_vector(31 downto 0);
BEGIN
	RegisterFile : register_file GENERIC MAP (32) PORT MAP(CLK,RST,instruction(9 downto 7),instruction(6 downto 4),Write_Enable,Write_Address_WB,Write_Data_WB,Rdst,Rsrc);
	Sign_Extend : signExtend PORT MAP(instruction, sign_extend_out);
	RD1 <= Rdst;
	RD2 <= Rsrc;
	RR1 <= instruction(9 downto 7);
	RR2 <= instruction(6 downto 4);
	ImmediateValue <= sign_extend_out;
	OUT_PORT <= Rdst;
end Architecture;