
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;

ENTITY Reg is
    port(
        SIGNAL clock : in std_logic;
 --       signal latch : in std_logic;
		signal inV  : in std_logic_vector(3 DOWNTO 0);
		signal outV  : out std_logic_vector(3 DOWNTO 0)
    );
end Reg;

architecture Bhv of Reg IS
	signal reg :  std_logic_vector(3 DOWNTO 0);
BEGIN
PROCESS(clock)
	BEGIN
		IF rising_edge(clock) THEN
			reg <= inV;
		END IF;
	END PROCESS;
	outV <= reg;
end architecture;