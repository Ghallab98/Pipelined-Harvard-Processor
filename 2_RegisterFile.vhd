LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
 

ENTITY register_file IS
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
END entity;


Architecture struct of register_file is 

component my_register IS
	PORT( 
		Clk,Rst 	: IN std_logic;
		enable 		: in std_logic;
		d 		: IN std_logic_vector(n-1 DOWNTO 0);
		q 		: OUT std_logic_vector(n-1 DOWNTO 0)
	);
END component;

component decoder is
	port(
		enable : in std_logic;
		address : in STD_LOGIC_VECTOR(2 downto 0);
		output 	: out STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component tri_state_buffer IS
PORT(
        my_in  : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        enable : IN STD_LOGIC;
        my_out : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);
END component;

signal r0_output,r1_output,r2_output,r3_output,r4_output,r5_output,r6_output,r7_output : std_logic_vector (n-1 downto 0);
signal enable_decoder_to_register ,enable_decoder_to_tristatebuffer_1,enable_decoder_to_tristatebuffer_2: std_logic_vector (7 downto 0);
signal read_enable : std_logic := '1';
begin

write_decoder : decoder port map (write_enable,write_address,enable_decoder_to_register);

read_decoder_1 : decoder port map (read_enable,read_address_1,enable_decoder_to_tristatebuffer_1);
read_decoder_2 : decoder port map (read_enable,read_address_2,enable_decoder_to_tristatebuffer_2);
 
r0: my_register generic map (n) port map (Clk,Rst,enable_decoder_to_register(0),write_databus,r0_output);
r1: my_register generic map (n) port map (Clk,Rst,enable_decoder_to_register(1),write_databus,r1_output);
r2: my_register generic map (n) port map (Clk,Rst,enable_decoder_to_register(2),write_databus,r2_output);
r3: my_register generic map (n) port map (Clk,Rst,enable_decoder_to_register(3),write_databus,r3_output);
r4: my_register generic map (n) port map (Clk,Rst,enable_decoder_to_register(4),write_databus,r4_output);
r5: my_register generic map (n) port map (Clk,Rst,enable_decoder_to_register(5),write_databus,r5_output);
r6: my_register generic map (n) port map (Clk,Rst,enable_decoder_to_register(6),write_databus,r6_output);
r7: my_register generic map (n) port map (Clk,Rst,enable_decoder_to_register(7),write_databus,r7_output);

tri0_RD1: tri_state_buffer generic map (n) port map (r0_output,enable_decoder_to_tristatebuffer_1(0),databus_1);
tri1_RD1: tri_state_buffer generic map (n) port map (r1_output,enable_decoder_to_tristatebuffer_1(1),databus_1);
tri2_RD1: tri_state_buffer generic map (n) port map (r2_output,enable_decoder_to_tristatebuffer_1(2),databus_1);
tri3_RD1: tri_state_buffer generic map (n) port map (r3_output,enable_decoder_to_tristatebuffer_1(3),databus_1);
tri4_RD1: tri_state_buffer generic map (n) port map (r4_output,enable_decoder_to_tristatebuffer_1(4),databus_1);
tri5_RD1: tri_state_buffer generic map (n) port map (r5_output,enable_decoder_to_tristatebuffer_1(5),databus_1);
tri6_RD1: tri_state_buffer generic map (n) port map (r6_output,enable_decoder_to_tristatebuffer_1(6),databus_1);
tri7_RD1: tri_state_buffer generic map (n) port map (r7_output,enable_decoder_to_tristatebuffer_1(7),databus_1);

tri0_RD2: tri_state_buffer generic map (n) port map (r0_output,enable_decoder_to_tristatebuffer_2(0),databus_2);
tri1_RD2: tri_state_buffer generic map (n) port map (r1_output,enable_decoder_to_tristatebuffer_2(1),databus_2);
tri2_RD2: tri_state_buffer generic map (n) port map (r2_output,enable_decoder_to_tristatebuffer_2(2),databus_2);
tri3_RD2: tri_state_buffer generic map (n) port map (r3_output,enable_decoder_to_tristatebuffer_2(3),databus_2);
tri4_RD2: tri_state_buffer generic map (n) port map (r4_output,enable_decoder_to_tristatebuffer_2(4),databus_2);
tri5_RD2: tri_state_buffer generic map (n) port map (r5_output,enable_decoder_to_tristatebuffer_2(5),databus_2);
tri6_RD2: tri_state_buffer generic map (n) port map (r6_output,enable_decoder_to_tristatebuffer_2(6),databus_2);
tri7_RD2: tri_state_buffer generic map (n) port map (r7_output,enable_decoder_to_tristatebuffer_2(7),databus_2);







end struct;