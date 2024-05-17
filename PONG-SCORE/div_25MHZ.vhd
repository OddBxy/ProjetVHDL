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
signal count : integer := 1;
signal tmp : std_logic := '0';
begin

  process(CLK, RST)
    
    begin
      if(rising_edge(CLK)) then
        count <=count+1;
        if (count = 2) then
          tmp <= NOT tmp;
          count <= 1;
          end if;
          
      end if;
      CLK_OUT <= tmp;
    end process;
   
end behaviour;
