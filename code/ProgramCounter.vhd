
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY work;
ENTITY ProgramCounter IS
    PORT (
        SIGNAL iRST : IN STD_LOGIC;
        SIGNAL oPC : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL iPC : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL iCLK : IN STD_LOGIC;
        SIGNAL ilatch : IN STD_LOGIC;
        signal iLDPC : in std_logic;
        SIGNAL iProgramCout : IN STD_LOGIC
    );
END ProgramCounter;

ARCHITECTURE Bhv OF ProgramCounter IS
    SIGNAL counter : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN
    PROCESS (iCLK)
    BEGIN
        IF rising_edge(iCLK) AND ilatch = '1' THEN
            counter <= counter + "1";
        elsif(rising_edge(iCLK)) and iLDPC = '1' THEN
            counter <= iPC;
        END IF;
        IF iRST = '1' THEN
            counter <= "0000";
        END IF;
    END PROCESS;


    PROCESS (iProgramCout, counter)
    BEGIN
        IF iProgramCout = '1' THEN
            oPC <= counter;
        END IF;
    END PROCESS;
END ARCHITECTURE;