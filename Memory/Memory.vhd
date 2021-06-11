Library ieee;
use ieee.std_logic_1164.all;

Entity Memory is
port(
data : inout std_logic_vector(7 downto 0);
RegisterCLK : in std_logic;
MemoryCLK : in std_logic;
RST : in std_logic;
write_Enable:in std_logic;
write_Address:in std_logic_vector(1 downto 0);
read_Enable:in std_logic;
read_Address:in std_logic_vector(1 downto 0)
);
end Entity;

Architecture my_Memory of Memory is
Component DFF is 
port(
enable: in std_logic;
D : in std_logic_vector(7 downto 0);
CLK : in std_logic;
RST : in std_logic;
Q : out std_logic_vector(7 downto 0));
end Component;
Component TriStateBuffer is
port(
enable:in std_logic;
dataIn:in std_logic_vector(7 downto 0);
dataOut:out std_logic_vector(7 downto 0));
end Component;
Component Decoder is 
port(
enable: in std_logic;
S:in std_logic_vector(1 downto 0);
Choose: out std_logic_vector(3 downto 0));
end Component;
Component Counter is
port(
RST : in std_logic;
CLK : in std_logic;
Address : out std_logic_vector(5 downto 0)
);
end Component;
Component RAM is
PORT (
RST : IN std_logic;
CLK : IN std_logic;
Write_Enable : IN std_logic;
Address : IN std_logic_vector(5 DOWNTO 0);
datain : IN std_logic_vector(7 DOWNTO 0);
dataout : OUT std_logic_vector(7 DOWNTO 0) 
);
end Component;

signal enableToRead,enableToWrite :std_logic_vector(3 downto 0);
type dataPassing is array (3 downto 0) of std_logic_vector(7 downto 0);
signal Qs : dataPassing;
signal Address : std_logic_vector(5 DOWNTO 0);
signal DataFromRam : std_logic_vector(7 DOWNTO 0);
signal enableRamRead,enableRamWrite : std_logic;
begin
Raddr : Decoder PORT MAP(read_Enable,read_Address,enableToRead);
Waddr : Decoder PORT MAP(write_Enable,write_Address,enableToWrite);
loop1: FOR i IN 0 TO 3 GENERATE
fx : DFF PORT MAP(enableToWrite(i),data,RegisterCLK,RST,Qs(i));
END GENERATE;
loop2: FOR j IN 0 TO 3 GENERATE
fx1 : TriStateBuffer PORT MAP(enableToRead(j),Qs(j),data);
END GENERATE;
count : Counter PORT MAP(RST,MemoryCLK,Address);
enableRamRead <= not read_Enable;
enableRamWrite <= not write_Enable;
TSB : TriStateBuffer PORT MAP(enableRamRead, DataFromRam, data);
my_RAM : RAM PORT MAP(RST,MemoryCLK,enableRamWrite,Address,data,DataFromRam);

end Architecture;