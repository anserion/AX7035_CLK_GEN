LIBRARY ieee; 
use IEEE.STD_LOGIC_1164.ALL, IEEE.STD_LOGIC_ARITH.ALL, ieee.std_logic_unsigned.all;

ENTITY tb_BCD_CONV IS
END tb_BCD_CONV;
ARCHITECTURE behavior OF tb_BCD_CONV IS 
    COMPONENT BCD_CONV
    PORT(SYS_CLK,KEY1,KEY2,RESET: IN std_logic;
         SMG_DATA: OUT std_logic_vector(7 downto 0);
         SCAN_SIG: OUT std_logic_vector(5 downto 0);
         LED1,LED2,LED3,LED4: OUT std_logic);
    END COMPONENT;
   --Inputs
   signal SYS_CLK: std_logic := '0';
   signal KEY1,KEY2,RESET: std_logic := '1';
 	--Outputs
   signal SMG_DATA: std_logic_vector(7 downto 0);
   signal SCAN_SIG: std_logic_vector(5 downto 0);
   signal LED1,LED2,LED3,LED4: std_logic;
   -- Clock period definitions
   constant SYS_CLK_period : time := 20 ns;
   -- others
   signal clk_cnt: natural:=0;
BEGIN
   uut: BCD_CONV PORT MAP (SYS_CLK,KEY1,KEY2,RESET,SMG_DATA,SCAN_SIG,LED1,LED2,LED3,LED4);
   -- Clock process definitions
   SYS_CLK_process :process
   begin
		SYS_CLK <= '0';
		wait for SYS_CLK_period/2;
		SYS_CLK <= '1';
		wait for SYS_CLK_period/2;
      clk_cnt<=clk_cnt+1;
   end process;
   -- Stimulus processAX7035
   stim_proc: process
   begin		
      wait for SYS_CLK_period;
      if clk_cnt=100000 then key1<='0'; end if;
      if clk_cnt=200000 then key1<='1'; end if;
      if clk_cnt=300000 then key1<='0'; end if;
      if clk_cnt=400000 then key1<='1'; end if;
      if clk_cnt=500000 then key1<='0'; end if;
      if clk_cnt=600000 then key1<='1'; end if;
      if clk_cnt=700000 then key2<='0'; end if;
      if clk_cnt=800000 then key2<='1'; end if;
      if clk_cnt=900000 then reset<='0'; end if;
      if clk_cnt=1000000 then reset<='1'; end if;
      if clk_cnt=1100000 then wait; end if;
   end process;
END;