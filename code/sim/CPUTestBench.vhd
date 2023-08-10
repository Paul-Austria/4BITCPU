
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
use work.all;

ENTITY CPUTestBench is
end CPUTestBench;

architecture Bhv of CPUTestBench IS
    SIGNAL clock :  std_logic := '1';
    signal clockO : std_logic := '1';
    signal Reset : std_logic := '0';
    SIGNAL HEX0 :  std_logic_vector(6 DOWNTO 0);
    SIGNAL HEX1 :  std_logic_vector(6 DOWNTO 0);
BEGIN

    CPU : entity work.CPU(Bhv) Port map(
        oCLK => clockO,
        iCLOCK_50 => clock,
        HEX0 => HEX0,
        HEX1 => HEX1,
        iReset => Reset
    );
    PROCESS 
    BEGIN
        clock <= not clock;
        wait for 5 ns;
    end PROCESS;
end architecture Bhv;