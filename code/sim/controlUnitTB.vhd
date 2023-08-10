
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.ALL;

ENTITY ControlUnitTB IS
END ControlUnitTB;

ARCHITECTURE Bhv OF ControlUnitTB IS
    SIGNAL clock : STD_LOGIC := '1';
    SIGNAL Outp : STD_LOGIC := '0';
    SIGNAL save : STD_LOGIC := '0';
    signal saveSigTest : std_logic;
    SIGNAL AdressLatch : STD_LOGIC := '0';
    SIGNAL Adress : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL inRam : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL outRam : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL outRamShort : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');



    signal cpuBus : std_logic_vector(3 DOWNTO 0);
    --signal outputs
    signal MemoryBusOut : std_logic_vector(3 DOWNTO 0);
    signal PCBusOut : std_logic_vector(3 DOWNTO 0);

    --program counter control
    SIGNAL latch : STD_LOGIC := '0';
    SIGNAL oPC : STD_LOGIC := '0';
    --memory control signals
    SIGNAL OutputMem : STD_LOGIC := '0';
    SIGNAL MemSave : STD_LOGIC := '0';
    SIGNAL MemAdressLatch : STD_LOGIC := '0';
    SIGNAL Ram : STD_LOGIC_VECTOR(7 DOWNTO 0);

    signal Reset : std_logic := '0';



    --ALU
    signal ALUAReg : std_logic_vector(3 downto 0);
    signal ALUALReg : STD_LOGIC_VECTOR(3 downto 0);

    signal LDA : std_logic := '0';
    signal LDB : std_logic := '0';
    signal oAR : std_logic := '0';
    signal SUB : std_logic := '0';
    signal OAL : std_logic := '0';


    --Hex
    signal hexOut : STD_LOGIC_VECTOR(6 DOWNTO 0);
    signal OutputRegLatch : std_logic := '0';
BEGIN
    mem : ENTITY work.memory(Bhv) PORT MAP(
        clock => clock,
        oOutp => OutputMem,
        isave => save,
        iAdressLatch => MemAdressLatch,
        iAdress => cpuBus,
        inRam => cpuBus,
        outRam => outRam,
        OutRamBus => MemoryBusOut
        );


    OutH : entity work.OutputHex(Bhv) port map(
        clk => clock,
        oHexOut => hexOut,
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
        iHex => cpuBus,
        Latch => OutputRegLatch
    );

    cu : ENTITY work.ControlUnit(Bhv) PORT MAP(
        CLK => clock,
        MEMIN => outRam(7 downto 4),

        PCOut => oPC,
        PCLatch => latch,

        MemOut => OutputMem,
        MemAdressLatch => MemAdressLatch,

        oLDA => LDA,
        oLDB => LDB,
        ooAR => oAR,
        oSUB => SUB,
        oOAL => OAL,
        
        oHexLatch => OutputRegLatch
        );

    PC : entity work.ProgramCounter(Bhv) PORT MAP(
        iRST => Reset,
        oPC => PCBusOut,
        iCLK => clock,
        ilatch => latch,
        iProgramCout => oPC
    );


    alu : entity work.alu(Bhv) PORT MAP(
        iA => cpuBus,
        iB => cpuBus,
        oA => ALUAReg,
        oAlu => ALUALReg,
        iLDA => LDA,
        iLDB => LDB,
        ioAR => oAR,
        iSUB => SUB,
        iOAL => OAL,
        iCLK => clock
    );



    PROCESS(PCBusOut, oPC, MemoryBusOut, OutputMem)
    BEGIN
        if oPC = '1' THEN
            cpuBus <= PCBusOut;
        elsif OutputMem = '1' THEN
            cpuBus <= MemoryBusOut;
        elsif oAR = '1'THEN
            cpuBus <= ALUAReg;
        elsif OAL = '1' THEN
            cpuBus <= ALUALReg;
        end if;
    end PROCESS;


    PROCESS
    BEGIN
        WAIT;
    END PROCESS;

    PROCESS
    BEGIN
        clock <= NOT clock;
        WAIT FOR 5 ns;
    END PROCESS;
END ARCHITECTURE Bhv;