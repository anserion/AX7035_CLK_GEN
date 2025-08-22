--Copyright 2025 Andrey S. Ionisyan (anserion@gmail.com)
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--    http://www.apache.org/licenses/LICENSE-2.0
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL, IEEE.STD_LOGIC_ARITH.ALL, ieee.std_logic_unsigned.all;

entity CLK_GEN_top is
Port (SYS_CLK,KEY1,KEY2,KEY3,KEY4,RESET: in STD_LOGIC; LED1: out STD_LOGIC);
end CLK_GEN_top;

architecture Behavioral of CLK_GEN_top is
   COMPONENT CLK_GEN
   Port (CLK_IN,EN,RESET: in STD_LOGIC;
         LOW_NUM, HIGH_NUM: natural;
         CLK_OUT : out  STD_LOGIC);
   END COMPONENT;
   signal low_num,high_num: natural:=25_000_000;
   signal btns_reg: std_logic;
begin
CLK_chip: CLK_GEN port map(SYS_CLK,'1',not(RESET),low_num,high_num,LED1);
btns_reg<=KEY1 and KEY2 and KEY3 and KEY4 and RESET;
process(btns_reg)
begin
   if falling_edge(btns_reg) then
      if RESET='0' then low_num<=25_000_000; high_num<=25_000_000; end if;
      if KEY1='0' then low_num<=low_num-1_000_000; end if;
      if KEY2='0' then low_num<=low_num+1_000_000; end if;
      if KEY3='0' then high_num<=high_num-1_000_000; end if;
      if KEY4='0' then high_num<=high_num+1_000_000; end if;
   end if;
end process;
end Behavioral;
