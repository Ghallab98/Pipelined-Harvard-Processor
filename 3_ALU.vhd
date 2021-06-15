Library ieee;
use ieee.std_logic_1164.all;


entity ALU is 
	GENERIC (n : integer := 32);
	port(
		R1		: in std_logic_vector (n-1 downto 0);
		R2		: in std_logic_vector (n-1 downto 0 );
		sel 		: in std_logic_vector (3 downto 0);
		immValue	: in std_logic_vector (4 downto 0 );
		Rout		: out std_logic_vector (n-1 downto 0);
		CF_In		: in std_logic;
		ZF_In		: in std_logic;
		NF_In		: in std_logic;
		CarryFlagOut	: out std_logic;
		ZeroFlagOut	: out std_logic;
		NegFlagOut	: out std_logic

	);

end entity;

ARCHITECTURE ALU_arch OF ALU IS

component oneOperand is
	port(
		R1		: in std_logic_vector (n-1 downto 0);
		sel 		: in std_logic_vector (2 downto 0);
		Rout		: out std_logic_vector (n-1 downto 0);
		CarryFlagIn	: in std_logic;
		ZeroFlagIn	: in std_logic;
		NegFlagIn	: in std_logic;
		CarryFlagOut	: out std_logic;
		ZeroFlagOut	: out std_logic;
		NegFlagOut	: out std_logic
	);	
end component;

component  twoOperand IS
	port (
		R1		: in std_logic_vector (n-1 downto 0);
		R2		: in std_logic_vector (n-1 downto 0 );
		sel 		: in std_logic_vector (2 downto 0);
		immValue	: in std_logic_vector (4 downto 0 );
		Rout		: out std_logic_vector (n-1 downto 0);
		CarryFlagIn	: in std_logic;
		ZeroFlagIn	: in std_logic;
		NegFlagIn	: in std_logic;
		CarryFlagOut	: out std_logic;
		ZeroFlagOut	: out std_logic;
		NegFlagOut	: out std_logic

	);
end component ;


SIGNAL Rout_1,Rout_2			:std_logic_vector(n-1 downto 0);
SIGNAL  NF_1,NF_2,ZF_1,ZF_2,CF_1,CF_2	: std_logic;


begin 

	u1: oneOperand generic map (n) PORT MAP (R1,sel(2 downto 0),Rout_1,CF_In,ZF_In,NF_In,CF_1,ZF_1,NF_1); 
	u2: twoOperand generic map (n) PORT MAP (R1,R2,sel(2 downto 0),immValue,Rout_2,CF_In,ZF_In,NF_In,CF_2,ZF_2,NF_2);

	

	Rout 		<= Rout_1 when sel(3) = '0'
			else Rout_2 ;


	CarryFlagOut 	<= CF_1 when sel(3) = '0'
			else CF_2 ;

	ZeroFlagOut 	<= ZF_1 when sel(3) = '0'
			else ZF_2 ;
	
	NegFlagOut 	<= NF_1 when sel(3) = '0'
			else NF_2 ;



end ALU_arch;

