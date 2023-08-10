--Simple test to turn on the LEDs.  Change the configuration of the architecture 
--to turn all the LEDS off

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


library work;
use work.all;

ENTITY main IS
	PORT(
		SIGNAL LEDR : OUT std_logic_vector(9 DOWNTO 0);
		SIGNAL SW : IN std_logic_vector(9 DOWNTO 0);
		SIGNAL LEDG : OUT std_logic_vector(7 DOWNTO 0);
        SIGNAL HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		SIGNAL HEX1 : OUT std_logic_vector(6 DOWNTO 0);
		signal key0 : in std_logic;
	   SIGNAL CLOCK_50 : IN  std_logic
	);
END main;

ARCHITECTURE logic OF main IS
signal cl: std_logic;
signal Reset : std_logic;
BEGIN
	Reset <= not key0;

	cp: CPU port map(iReset => Reset,iCLOCK_50 => CLOCK_50, oCLK => cl, HEX0 => HEX0, HEX1 => HEX1);
    LEDR(0) <= cl;
	ledr(1) <= Reset;
END ARCHITECTURE logic;





