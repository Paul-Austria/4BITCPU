LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY work;

ENTITY OutputHex IS
    PORT (
        SIGNAL clk : IN STD_LOGIC;
        SIGNAL oHexOut : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        SIGNAL iHex : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL Latch : IN STD_LOGIC
    );
END OutputHex;

ARCHITECTURE Bhv OF OutputHex IS
    signal h : STD_LOGIC_VECTOR(6 DOWNTO 0);
    signal inp : STD_LOGIC_VECTOR(3 DOWNTO 0);
    FUNCTION ToSevSeg(cValue : STD_LOGIC_VECTOR(3 DOWNTO 0))
        RETURN STD_LOGIC_VECTOR IS
    BEGIN

        CASE cValue(3 DOWNTO 0) IS
            WHEN "0000" => RETURN "0111111";
            WHEN "0001" => RETURN "0000110";
            WHEN "0010" => RETURN "1011011";
            WHEN "0011" => RETURN "1001111";
            WHEN "0100" => RETURN "1100110";
            WHEN "0101" => RETURN "1101101";
            WHEN "0110" => RETURN "1111101";
            WHEN "0111" => RETURN "0000111";
            WHEN "1000" => RETURN "1111111";
            WHEN "1001" => RETURN "1101111";
            WHEN "1010" => RETURN "1110111";
            WHEN "1011" => RETURN "1111100";
            WHEN "1100" => RETURN "0111001";
            WHEN "1101" => RETURN "1011110";
            WHEN "1110" => RETURN "1111001";
            WHEN "1111" => RETURN "1110001";
            WHEN OTHERS => RETURN "1111111";
        END CASE;
    END ToSevSeg;

BEGIN
    PROCESS (clk, Latch)
    BEGIN
        IF Latch = '1' THEN
            IF clk = '1' THEN
                h <= ToSevSeg(iHex);
                inp <= iHex;
            END IF;
        END IF;
    END PROCESS;
    oHexOut <= h;
END ARCHITECTURE;