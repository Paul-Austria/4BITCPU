
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
use work.all;

ENTITY CPU is
    port(signal oCLK : out std_logic;
        signal iCLOCK_50 : in std_logic;
        signal iReset : in std_logic;
        SIGNAL HEX0 : OUT std_logic_vector(6 DOWNTO 0);
		SIGNAL HEX1 : OUT std_logic_vector(6 DOWNTO 0)
    );
end CPU;

architecture Bhv of CPU IS
    signal  cl: std_logic;
    signal HexOut1 :  std_logic_vector(6 DOWNTO 0); 
    signal HexOut2 :  std_logic_vector(6 DOWNTO 0); 

    signal cpuBus : std_logic_vector(3 DOWNTO 0);
    signal Save : std_logic_vector(3 DOWNTO 0);


    signal Reset : std_logic := '0';
    

--signal outputs
    signal MemoryBusOut : std_logic_vector(3 DOWNTO 0);
    signal PCBusOut : std_logic_vector(3 DOWNTO 0);

    --program counter control
    SIGNAL latch : STD_LOGIC := '0';
    SIGNAL oPC : STD_LOGIC := '0';
    signal LDPC : std_logic := '0';
    --memory control signals
    SIGNAL OutputMem : STD_LOGIC := '0';
    SIGNAL MemSave : STD_LOGIC := '0';
    SIGNAL MemAdressLatch : STD_LOGIC := '0';
    SIGNAL Ram : STD_LOGIC_VECTOR(7 DOWNTO 0);




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

    --MISC
    --cl <= iCLOCK_50;
    CpuCLK: ENTITY work.clk(Bhv) port map(CLOCK_50 => iCLOCK_50, outClk => cl);
    Reset <= iReset;
    oCLK <= cl;


    mem : ENTITY work.memory(Bhv) port map(
        clock => cl,
        oOutp => OutputMem,
        isave => MemSave,
        iAdressLatch => MemAdressLatch,
        iAdress => cpuBus,
        inRam => cpuBus,
        outRam => Ram,
        OutRamBus => MemoryBusOut
    );

    cu : ENTITY work.ControlUnit(Bhv) PORT MAP(
        CLK => cl,
        MEMIN => Ram(7 downto 4),

        PCOut => oPC,
        PCLatch => latch,
        LDPC => LDPC,
         
        MemOut => OutputMem,
        MemAdressLatch => MemAdressLatch,

        oLDA => LDA,
        oLDB => LDB,
        ooAR => oAR,
        oSUB => SUB,
        oOAL => OAL,
        
        oHexLatch => OutputRegLatch
        );

    PC : entity work.ProgramCounter(Bhv) port map(
        iRST => Reset,
        oPC => PCBusOut,
        iCLK => cl,
        ilatch => latch,
        iProgramCout => oPC,
        iPC => cpuBus,
        iLDPC => LDPC
    );

    al : entity work.alu(Bhv) PORT MAP(
        iA => cpuBus,
        iB => cpuBus,
        oA => ALUAReg,
        oAlu => ALUALReg,
        iLDA => LDA,
        iLDB => LDB,
        ioAR => oAR,
        iSUB => SUB,
        iOAL => OAL,
        iCLK => cl
    );

    
    --Bus Handeling
    PROCESS(PCBusOut, oPC, MemoryBusOut, OutputMem, oAR, ALUAReg,OAL, ALUALReg)
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


    HexConv1 : entity work.OutputHex(Bhv) port map (oHexOut => HexOut1,
    iHex => cpuBus,
    Latch => OutputRegLatch,
    clk => cl);
    HEX0 <= not HexOut1;
end architecture;