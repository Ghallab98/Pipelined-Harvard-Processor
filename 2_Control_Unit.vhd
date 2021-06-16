library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
	port(
		opCode: in std_logic_vector(4 downto 0);
		controlOut : out std_logic_vector(20 downto 0);
		Immediate_Signal : out std_logic
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

begin
	with opCode select
		controlOut <=   "000000000000000000001" when op_NOP,
					    "000100000000011000000" when op_SETC,
					    "001000000000001000000" when op_CLRC,
						"001100011000000000000" when op_NOT,
						"010000011000000000000" when op_INC,
						"010100011000000000000" when op_DEC,
						"011000000010000000000" when op_OUT,
						"011100011100000000000" when op_IN,
						"100000011000000000000" when op_MOV,
						"100100011000000000000" when op_ADD,
						"101000011000100000000" when op_IADD,
						"101100011000000000000" when op_SUB,
						"110000011000000000000" when op_AND,
						"110100011000000000000" when op_OR,
						"111000011000000000000" when op_SHL,
						"111100011000000000000" when op_SHR,
						"000001000000000110000" when op_PUSH,
						"000010111000000111000" when op_POP,
						"000010111000100000000" when op_LDM,
						"101010111001000000000" when op_LDD,
						"101001000001000000000" when op_STD,
						"000000000000000000001" when op_JZ,
						"000000000000000000001" when op_JN,
						"000000000000000000001" when op_JC,
						"000000000000000000001" when op_JMP,
						"000001000000000110100" when op_CALL,
						"000010100000000111011" when op_RET,
						"000000000000000000000" when OTHERS;
	Immediate_Signal <= '1' when opCode = op_IADD or opCode = op_LDM or opCode = op_LDD or opCode = op_STD
					else '0';
end Architecture;