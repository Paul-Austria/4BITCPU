
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
use work.all;

ENTITY memory is
    port(
        SIGNAL clock : in std_logic;
        signal oOutp : in std_logic;
        signal isave : in std_logic;
        signal iAdressLatch : in std_logic;
        signal iAdress : in std_logic_vector(3 downto 0);
        signal inRam : in std_logic_vector(3 downto 0);
        signal outRam : out std_logic_vector(7 downto 0); -- for ControlUnit
        signal OutRamBus : out std_logic_vector(3 downto 0) -- for CPU Bus
    );
end memory;

architecture Bhv of memory IS

    TYPE   RAM IS ARRAY(15 downto 0) OF std_logic_vector(7 downto 0); 
	signal ramStore : RAM := (
        0 => "00010000", -- LDA 0
        1 => "00110001", -- LDB 1
        2 => "01000000", -- ADD
        3 => "00100000", -- OUT
        4 => "01010010", -- JMP 2
        5 => "00000000", 
        6 => "00000000", 
        7 => "00000000",
        8 => "00000000",
        9 => "00000000",
        10 =>"00000000",
        11 =>"00000000",
        12 =>"00000000",
        13 =>"00000000",
        14 =>"00000000",
        15 =>"00000000"
    );
    signal currrentAdress : std_logic_vector(3 downto 0);
BEGIN

--save ram
PROCESS(clock)
	BEGIN
		IF rising_edge(clock) and isave = '1' THEN
			ramStore(to_integer(unsigned(currrentAdress)) )(3 downto 0) <= inRam;
		END IF;
	END PROCESS;


--output ram
PROCESS(oOutp, currrentAdress)
    BEGIN
        if oOutp = '1' THEN
            outRam <= ramStore(to_integer(unsigned(currrentAdress)));
            OutRamBus <= ramStore(to_integer(unsigned(currrentAdress)))(3 downto 0);
        end if;
end PROCESS;

--set adress
PROCESS(iAdressLatch, clock, iAdress)
BEGIN
    if iAdressLatch = '1' and rising_edge(clock) THEN
        currrentAdress <= iAdress;
    end if;
end PROCESS;

end architecture;