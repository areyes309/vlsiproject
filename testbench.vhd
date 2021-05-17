library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

COMPONENT controller
PORT(
     sensor : IN  std_logic;
     clk : IN  std_logic;
     rst : IN  std_logic;
     WestEast : OUT  std_logic_vector(2 downto 0);
     NorthSouth : OUT  std_logic_vector(2 downto 0)
    );
END COMPONENT;
	
signal sensor : std_logic := '0';
signal clk : std_logic := '0';
signal rst : std_logic := '0';
signal WestEast : std_logic_vector(2 downto 0);
signal NorthSouth : std_logic_vector(2 downto 0);
constant clk_period : time := 10 ns;
   
BEGIN

trafficlightcontroller : controller PORT MAP (
sensor => sensor,
clk => clk,
rst => rst,
WestEast => WestEast,
NorthSouth => NorthSouth
);
		
clk_process :process
   
begin
clk <= '0';
wait for clk_period/2;
clk <= '1';
wait for clk_period/2;
end process;
stim_proc: process
begin    
rst <= '0';
sensor <= '0';
wait for clk_period*10;
rst <= '1';
wait for clk_period*20;
sensor <= '1';
wait for clk_period*100;
sensor <= '0';
wait for clk_period*100;
wait;
end process;

end Behavioral;