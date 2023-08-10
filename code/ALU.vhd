
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY work;
USE work.ALL;
ENTITY ALU IS
    PORT (
        SIGNAL iA : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL iB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL oA : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL oAlu : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

        SIGNAL iCLK : IN STD_LOGIC;
        SIGNAL iLDA : IN STD_LOGIC;
        SIGNAL iLDB : IN STD_LOGIC;
        SIGNAL ioAR : IN STD_LOGIC;
        SIGNAL iSUB : IN STD_LOGIC;
        SIGNAL iOAL : IN STD_LOGIC
    );
END ALU;

ARCHITECTURE BHV OF ALU IS
    SIGNAL AReg : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL BReg : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
BEGIN
    PROCESS (iCLK)
    BEGIN
        IF rising_edge(iCLK) THEN
            IF iLDA = '1' THEN
                AReg <= iA;
            END IF;
            IF iLDB = '1' THEN
                BReg <= iB;
            END IF;
        END IF;
    END PROCESS;
    PROCESS (ioAR)
    BEGIN
        IF ioAR = '1' THEN
            oA <= AReg;
        END IF;
    END PROCESS;

    PROCESS (iOAL)
    BEGIN
        IF iOAL = '1' THEN
            IF iSUB = '0' THEN
                oAlu <= (AReg + BReg);
            ELSE
                oAlu <= AReg + (not BReg) + '1';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;