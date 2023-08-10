
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY work;
USE work.ALL;
ENTITY ControlUnit IS
    PORT (
        SIGNAL CLK : IN STD_LOGIC;
        SIGNAL MEMIN : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        --PC
        SIGNAL PCOut : OUT STD_LOGIC;
        SIGNAL PCLatch : OUT STD_LOGIC;
        signal LDPC : out std_logic;
        --MEMORY
        SIGNAL MemOut : OUT STD_LOGIC;
        SIGNAL MemAdressLatch : OUT STD_LOGIC;

        --ALU
        SIGNAL oLDA : OUT STD_LOGIC;
        SIGNAL oLDB : OUT STD_LOGIC;
        SIGNAL ooAR : OUT STD_LOGIC;
        SIGNAL oSUB : OUT STD_LOGIC;
        SIGNAL oOAL : OUT STD_LOGIC;

        --OutputRegister
        SIGNAL oHexLatch : OUT STD_LOGIC
    );
END ControlUnit;

ARCHITECTURE BHV OF ControlUnit IS
    SIGNAL currentInst : INTEGER := 0;
    SIGNAL instructionIn : STD_LOGIC := '0';
BEGIN

    PROCESS (CLK)
        VARIABLE currentCommand : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    BEGIN
        IF (rising_edge(CLK)) THEN
            IF instructionIn = '1' THEN
                currentCommand := MEMIN;
            END IF;
            IF currentInst < 2 THEN
                CASE currentInst IS
                    WHEN 0 =>
                        --PC
                        PCOut <= '1';
                        PCLatch <= '0';
                        LDPC <= '0';
                        --MEMORY
                        MemOut <= '0';
                        instructionIn <= '0';
                        PCLatch <= '0';
                        MemAdressLatch <= '1';

                        --ALU
                        oLDA <= '0';
                        oLDB <= '0';
                        ooAR <= '0';
                        oSUB <= '0';
                        oOAL <= '0';

                        --OutputRegister
                        oHexLatch <= '0';

                        currentInst <= currentInst + 1;
                    WHEN 1 =>
                        --PC
                        PCOut <= '0';
                        PCLatch <= '0';
                        LDPC <= '0';

                        --MEMORY
                        MemOut <= '1';
                        instructionIn <= '1';
                        PCLatch <= '0';
                        MemAdressLatch <= '0';
                        --ALU
                        oLDA <= '0';
                        oLDB <= '0';
                        ooAR <= '0';
                        oSUB <= '0';
                        oOAL <= '0';
                        --OutputRegister
                        oHexLatch <= '0';

                        currentInst <= currentInst + 1;
                    WHEN OTHERS =>
                END CASE;
            ELSIF currentCommand = "0001" THEN --lda
                CASE currentInst IS
                    WHEN 2 =>
                        --PC
                        PCOut <= '0';
                        PCLatch <= '0';
                        LDPC <= '0';

                        --MEMORY
                        MemOut <= '1';
                        instructionIn <= '0';
                        PCLatch <= '1';
                        MemAdressLatch <= '0';
                        --ALU
                        oLDA <= '1';
                        oLDB <= '0';
                        ooAR <= '0';
                        oSUB <= '0';
                        oOAL <= '0';
                        --OutputRegister
                        oHexLatch <= '0';

                        currentInst <= 0;
                    WHEN OTHERS =>
                END CASE;
            ELSIF currentCommand = "0010" THEN --out
                CASE currentInst IS
                    WHEN 2 =>
                        --PC
                        PCOut <= '0';
                        PCLatch <= '0';
                        LDPC <= '0';

                        --MEMORY
                        MemOut <= '0';
                        instructionIn <= '0';
                        PCLatch <= '1';
                        MemAdressLatch <= '0';
                        --ALU
                        oLDA <= '0';
                        oLDB <= '0';
                        ooAR <= '1';
                        oSUB <= '0';
                        oOAL <= '0';
                        --OutputRegister
                        oHexLatch <= '1';

                        currentInst <= 0;
                    WHEN OTHERS =>
                END CASE;
            ELSIF currentCommand = "0011" THEN --ldb
                CASE currentInst IS
                    WHEN 2 =>
                        --PC
                        PCOut <= '0';
                        PCLatch <= '0';
                        LDPC <= '0';

                        --MEMORY
                        MemOut <= '1';
                        instructionIn <= '0';
                        PCLatch <= '1';
                        MemAdressLatch <= '0';
                        --ALU
                        oLDA <= '0';
                        oLDB <= '1';
                        ooAR <= '0';
                        oSUB <= '0';
                        oOAL <= '0';
                        --OutputRegister
                        oHexLatch <= '0';

                        currentInst <= 0;
                    WHEN OTHERS =>
                END CASE;
            ELSIF currentCommand = "0100" THEN --ADD
                CASE currentInst IS
                    WHEN 2 =>
                        --PC
                        PCOut <= '0';
                        PCLatch <= '0';
                        LDPC <= '0';

                        --MEMORY
                        MemOut <= '0';
                        instructionIn <= '0';
                        PCLatch <= '1';
                        MemAdressLatch <= '0';
                        --ALU
                        oLDA <= '1';
                        oLDB <= '0';
                        ooAR <= '0';
                        oSUB <= '0';
                        oOAL <= '1';
                        --OutputRegister
                        oHexLatch <= '0';

                        currentInst <= 0;
                    WHEN OTHERS =>
                END CASE;
            ELSIF currentCommand = "0101" THEN --JMP
            CASE currentInst IS
                WHEN 2 =>
                    --PC
                    PCOut <= '0';
                    PCLatch <= '0';
                    LDPC <= '1';

                    --MEMORY
                    MemOut <= '1';
                    instructionIn <= '0';
                    PCLatch <= '0';
                    MemAdressLatch <= '0';
                    --ALU
                    oLDA <= '0';
                    oLDB <= '0';
                    ooAR <= '0';
                    oSUB <= '0';
                    oOAL <= '0';
                    --OutputRegister
                    oHexLatch <= '0';

                    currentInst <= 0;
                WHEN OTHERS =>
            END CASE;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;