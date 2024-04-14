library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_25MHZ is
  port(
    CLK : in std_logic;
    RST : in std_logic;
    CLK_OUT : out std_logic
  );
end div_25MHZ;

architecture behaviour of div_25MHZ is
begin
  
  process(CLK, RST)
    
    variable cnt : natural := 0;  
    begin
      if(RST = '1') then
        CLK_OUT <= '0';
      elsif(rising_edge(CLK)) then
        case cnt is
          when 4 => 
            CLK_OUT <= '1';
            cnt := 0;
          when others =>
            CLK_OUT <= '0';
            cnt := cnt + 1;
        end case;
      end if;
   end process;
   
end behaviour;