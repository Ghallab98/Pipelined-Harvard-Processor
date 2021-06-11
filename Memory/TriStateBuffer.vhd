Library ieee;
use ieee.std_logic_1164.all;

Entity TriStateBuffer is
GENERIC (n: integer :=8);
port(
enable:in std_logic;
dataIn:in std_logic_vector(n-1 downto 0);
dataOut:out std_logic_vector(n-1 downto 0));
end Entity;

Architecture my_TriStateBuffer of TriStateBuffer is
Begin
dataOut <= dataIn When enable = '1'
else (OTHERS=> 'Z');
end Architecture;