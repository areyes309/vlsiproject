library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity controller is
port (  sensor  : in STD_LOGIC;
        clk  : in STD_LOGIC; 
        rst: in STD_LOGIC;
        WestEast  : out STD_LOGIC_VECTOR(2 downto 0);
		NorthSouth:    out STD_LOGIC_VECTOR(2 downto 0)
   );
end controller;

architecture Behavioral of controller is

signal count: std_logic_vector(27 downto 0):= x"0000000";
signal delay_count:std_logic_vector(3 downto 0):= x"0";
signal timerC : std_logic:='0'; 
signal timerA : std_logic:='0';
signal timerB : std_logic:='0';
signal enableR : std_logic:='0'; 
signal enableY : std_logic:='0';
signal enableG: std_logic:='0';
signal enable_clk: std_logic;
type FSM_States is (WE_G_NS_R, WE_Y_NS_R, WE_R_NS_G, WE_R_NS_Y);
signal current_state, next_state: FSM_States;
begin

-- next state FSM sequential logic 
process(clk,rst) 
begin
if(rst='0') then
    current_state <= WE_G_NS_R;
elsif(rising_edge(clk)) then 
    current_state <= next_state; 
end if; 
end process;

-- FSM combinational logic 
process(current_state,sensor,timerA,timerB,timerC)
begin
    case current_state is 
    
        when WE_G_NS_R => 
            enableR <= '0';
            enableY <= '0';
            enableG <= '0';
            WestEast <= "001";
            NorthSouth <= "100"; 
 if(sensor = '1') then
    next_state <= WE_Y_NS_R; 
 else 
    next_state <= WE_G_NS_R; 
 end if;
 
        when WE_Y_NS_R =>
            WestEast <= "010";
            NorthSouth <= "100";
            enableR <= '0';
            enableY <= '1';
            enableG <= '0';
 if(timerB='1') then 
    next_state <= WE_R_NS_G; 
 else 
    next_state <= WE_Y_NS_R; 
 end if;
 

        when WE_R_NS_G => 
            WestEast <= "100";-- RED light on WestEast 
            NorthSouth <= "001";-- GREEN light on NorthSouth  
            enableR <= '1';-- enable RED light delay counting
            enableY <= '0';-- disable YELLOW light WestEast delay counting
            enableG <= '0';-- disable YELLOW light NorthSouth delay counting
 if(timerC='1') then
    next_state <= WE_R_NS_Y;
 else 
    next_state <= WE_R_NS_G; 
 end if;
 
 
           when WE_R_NS_Y =>
                WestEast <= "100";-- RED light on WestEast 
                NorthSouth <= "010";-- Yellow light on NorthSouth  
                enableR <= '0'; -- disable RED light delay counting
                enableY <= '0';-- disable YELLOW light WestEast delay counting
                enableG <= '1';-- enable YELLOW light NorthSouth delay counting
 if(timerA='1') then 
    next_state <= WE_G_NS_R;
 else 
    next_state <= WE_R_NS_Y;
 end if;
 
 
when others => next_state <= WE_G_NS_R; 
end case;
end process;

-- Controller for Lights
process(clk)
begin
if(rising_edge(clk)) then 
if(enable_clk='1') then
 if(enableR='1' or enableY='1' or enableG='1') then
  delay_count <= delay_count + x"1";
  if((delay_count = x"9") and enableR ='1') then 
   timerC <= '1';
   timerB <= '0';
   timerA <= '0';
   delay_count <= x"0";
  elsif((delay_count = x"2") and enableY= '1') then
   timerC <= '0';
   timerB <= '1';
   timerA <= '0';
   delay_count <= x"0";
  elsif((delay_count = x"2") and enableG= '1') then
   timerC <= '0';
   timerB <= '0';
   timerA <= '1';
   delay_count <= x"0";
  else
   timerC <= '0';
   timerB <= '0';
   timerA <= '0';
  end if;
 end if;
 end if;
end if;
end process;


-- create a clock delay of 1 second
process(clk)
begin
if(rising_edge(clk)) then 
 count <= count + x"0000001";
 if(count >= x"0000003") then
  count <= x"0000000";
 end if;
end if;
end process;
enable_clk <= '1' when count = x"0003" else '0';


end Behavioral;