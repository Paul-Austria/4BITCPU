
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;

ENTITY CLK is
    port(
        SIGNAL CLOCK_50 : in std_logic;
        signal outClk : out std_logic
    );
end CLK;

architecture Bhv of CLK IS
    CONSTANT FREQUENCY      : INTEGER := 50000000;
	CONSTANT FLIP_FREQUENCY : INTEGER := 100;
	CONSTANT COUNTREACHED   : INTEGER := FREQUENCY / FLIP_FREQUENCY;
    SIGNAL counter          : unsigned(25 DOWNTO 0);
    signal ledSignal : std_logic;
BEGIN
PROCESS(CLOCK_50)
	BEGIN
		IF rising_edge(CLOCK_50) THEN
			IF counter = COUNTREACHED THEN
				counter   <= to_unsigned(0, 26);
				-- Flip the current value of ledSignal
				ledSignal <= NOT ledSignal;
			ELSE
				counter <= counter + 1;
			END IF;
		END IF;
	END PROCESS;
	outClk <= ledSignal;
end architecture;