
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
use work.all;

ENTITY memoryTestBench is
end memoryTestBench;

architecture Bhv of memoryTestBench IS
    SIGNAL clock :  std_logic := '1';
    signal Outp :  std_logic := '0';
    signal save :  std_logic:= '0';
    signal AdressLatch :  std_logic:= '0';
    signal Adress :  std_logic_vector(3 downto 0) := (others => '0');
    signal inRam :  std_logic_vector(3 downto 0):= (others => '0');
    signal outRam :  std_logic_vector(7 downto 0):= (others => '0');
    signal outRamShort : std_logic_vector(3 downto 0):= (others => '0');
BEGIN
    mem : entity work.memory(Bhv) port map(
        clock => clock,
        oOutp => Outp,
        isave => save,
        iAdressLatch => AdressLatch,
        iAdress => Adress,
        inRam => inRam,
        outRam => outRam,
        OutRamBus => outRamShort
    );


    PROCESS 
    BEGIN
        --set adressses 
        Adress <= "0001";
        AdressLatch <= '1';
        wait for 11 ns;
        AdressLatch <= '0';
        inRam <= "1010";
        save <= '1';
        wait for 11 ns;
        save <= '0';
        Outp <= '1';

        wait;
    end PROCESS;

    PROCESS 
    BEGIN
        clock <= not clock;
        wait for 5 ns;
    end PROCESS;
end architecture Bhv;