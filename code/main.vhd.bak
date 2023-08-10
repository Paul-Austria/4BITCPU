--Simple test to turn on the LEDs.  Change the configuration of the architecture 
--to turn all the LEDS off

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY top_level IS
	PORT(
		SIGNAL LEDR : OUT std_logic_vector(9 DOWNTO 0);
		SIGNAL LEDG : OUT std_logic_vector(7 DOWNTO 0);
		SIGNAL HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		SIGNAL HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		SIGNAL HEX2 : OUT std_logic_vector(6 DOWNTO 0);
		SIGNAL HEX3 : OUT std_logic_vector(6 DOWNTO 0)
	);
END top_level;

ARCHITECTURE logic OF top_level IS
BEGIN
	LEDR(0) <= '1';
	LEDR(1) <= '0';
	LEDR(2) <= '1';
	LEDR(3) <= '0';
	LEDR(4) <= '1';
	LEDR(5) <= '0';
	LEDR(6) <= '1';
	LEDR(7) <= '0';
	LEDR(8) <= '0';
	LEDR(9) <= '0';

	-- Should be the same as
	LEDR <= "0001010101";
	-- While this will produce an error
	-- LEDR <= "0101010111";

	-- Set the green LEDs
	LEDG <= "10101010";

	-- set the 4 digit HEX display to 1234, 1=OFF for some reason
	HEX3 <= "1111001";                  -- leftmost HEX, number 1
	HEX2 <= "0100100";                  -- number 2
	HEX1 <= "0110000";                  -- number 3
	HEX0 <= "0011001";                  -- rightmost hex, number 4

END ARCHITECTURE logic;

ARCHITECTURE logic_all_off OF top_level IS
BEGIN
	LEDR <= "0000000000";
	LEDG <= "00000000";
	HEX3 <= "1111111";
	HEX2 <= "1111111";
	HEX1 <= "1111111";
	HEX0 <= "1111111";
END ARCHITECTURE logic_all_off;

CONFIGURATION conf OF top_level IS
	FOR logic
	END FOR;
END CONFIGURATION conf;


