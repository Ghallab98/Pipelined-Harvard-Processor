library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
	port(
		opCode: in std_logic_vector(4 downto 0);
	);
end ControlUnit;

architecture archControlUnit of ControlUnit is
--One Operand
	constant op_NOP : std_logic_vector(4 downto 0) := "00000";
	constant op_SETC : std_logic_vector(4 downto 0) := "00001";
	constant op_CLRC : std_logic_vector(4 downto 0) := "00010";
	constant op_NOT : std_logic_vector(4 downto 0) := "00011";
	constant op_INC : std_logic_vector(4 downto 0) := "00100";
	constant op_DEC : std_logic_vector(4 downto 0) := "00101";
	constant op_OUT : std_logic_vector(4 downto 0) := "00110";
	constant op_IN : std_logic_vector(4 downto 0) := "00111";
--Two Operands
	constant op_MOV : std_logic_vector(4 downto 0) := "01000";
	constant op_ADD : std_logic_vector(4 downto 0) := "01001";
	constant op_IADD : std_logic_vector(4 downto 0) := "01010";
	constant op_SUB : std_logic_vector(4 downto 0) := "01011";
	constant op_AND : std_logic_vector(4 downto 0) := "01100";
	constant op_OR : std_logic_vector(4 downto 0) := "01101";
	constant op_SHL : std_logic_vector(4 downto 0) := "01110";
	constant op_SHR : std_logic_vector(4 downto 0) := "01111";
--Memory
	constant op_PUSH : std_logic_vector(4 downto 0) := "10000";
	constant op_POP : std_logic_vector(4 downto 0) := "10001";
	constant op_LDM : std_logic_vector(4 downto 0) := "10010";
	constant op_LDD : std_logic_vector(4 downto 0) := "10011";
	constant op_STD : std_logic_vector(4 downto 0) := "10100";
--Branch and Change of Control
	constant op_JZ : std_logic_vector(4 downto 0) := "11000";
	constant op_JN : std_logic_vector(4 downto 0) := "11001";
	constant op_JC : std_logic_vector(4 downto 0) := "11010";
	constant op_JMP : std_logic_vector(4 downto 0) := "11011";
	constant op_CALL : std_logic_vector(4 downto 0) := "11100";
	constant op_RET : std_logic_vector(4 downto 0) := "11101";

signal controlOut : std_logic_vector(17 downto 0);
begin
	with opCode select
		controlOut <=   "000000000000000001" when op_op_NOP;
					    "000000000011000000" when op_SETC,
					    "000000000001000000" when op_CLRC,
						"000011000000000000" when op_NOT,
						"000011000000000000" when op_INC,
						"000011000000000000" when op_DEC,
						"000000010000000000" when op_OUT,
						"000011100000000000" when op_IN,
						"000011000000000000" when op_MOV,
						"000011000000000000" when op_ADD,
						"" when op_IADD,
						"" when op_SUB,
						"" when op_AND,
						"" when op_OR,
						"" when op_SHL,
						"" when op_SHR,
						"" when op_PUSH,
						"" when op_POP,
						"" when op_LDM,
						"" when op_LDD,
						"" when op_STD,
						"" when op_JZ,
						"" when op_JN,
						"" when op_JC,
						"" when op_JMP,
						"" when op_CALL,
						"" when op_RET,