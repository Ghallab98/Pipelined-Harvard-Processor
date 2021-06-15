LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY SPCounter IS
GENERIC(
    AddressWidth : INTEGER := 32
    );
	PORT(
        clk         : IN std_logic;
		enable      : IN  std_logic;
		push_pop    : IN  std_logic;   -- 0 for push(-2) 1 for pop(+2)
		adddressSP    : OUT std_logic_vector(AddressWidth-1 DOWNTO 0)
		);
END ENTITY SPCounter;

Architecture SPCounterArchi OF SPCounter IS
    signal popMuxOutput,pushMuxOutput,regOutput1,regOutput2,popAdderOutput,pushAdderOutput : std_logic_vector (AddressWidth-1 downto 0); 
    Component reg IS 
        port(
            clk : in std_logic;
            en : in std_logic;
            d : in std_logic_vector(AddressWidth-1 downto 0);
            q : out std_logic_vector(AddressWidth-1 downto 0));    
    end Component;
---------------------------------------------------------------
    Component MUX_2x1 IS
        PORT( 
		    in0:  IN  std_logic_vector (AddressWidth-1 DOWNTO 0);
		    in1:  IN  std_logic_vector (AddressWidth-1 DOWNTO 0);
		    sel:  IN  std_logic;
		    outm: OUT std_logic_vector (AddressWidth-1 DOWNTO 0)
	    );
    end Component;
---------------------------------------------------------------
    begin
    --Read from the sp register at the begining
    spReg   : reg PORT MAP (clk,enable,pushMuxOutput,regOutput1); 
    --Add 2 for pop
    popAdderOutput <= std_logic_vector(to_unsigned( (to_integer(unsigned(regOutput1)) +2 ), 32));
    popMUX  : MUX_2x1 PORT MAP(regOutput1,popAdderOutput,push_pop,popMuxOutput);
    adddressSP <= popMuxOutput;
    --Sub 2 for push
    pushAdderOutput<=std_logic_vector(to_unsigned( (to_integer(unsigned(popMuxOutput)) - 2 ), 32));
    pushMUX : MUX_2x1 PORT MAP(pushAdderOutput,popMuxOutput,push_pop,pushMuxOutput);
    --Write in the register lasy step read is 0 and write enable is 1
end SPCounterArchi;