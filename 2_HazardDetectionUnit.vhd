LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY HazardDetectionUnit IS
	PORT(
		registerDecode1,registerDecode2,registerExecute: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		isExecuteLoad: IN STD_LOGIC;
		fetchDecodeNOP,programCounterMUX: OUT STD_LOGIC 
	);
END ENTITY HazardDetectionUnit;

ARCHITECTURE HazardDetectionUnitArch OF HazardDetectionUnit IS
BEGIN
	fetchDecodeNOP <= '1' WHEN isExecuteLoad = '1' AND (registerDecode1 = registerExecute OR registerDecode2 = registerExecute)
			ELSE '0';
	programCounterMUX <= '1' WHEN isExecuteLoad = '1' AND (registerDecode1 = registerExecute OR registerDecode2 = registerExecute)
			ELSE '0';
END ARCHITECTURE;