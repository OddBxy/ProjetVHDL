library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity an_selector is
  port(
    CLK_16MS : in std_logic;
    RST : in std_logic;
    AN : out std_logic_vector (3 downto 0) := "1110"
  );
end an_selector;


architecture mac of an_selector is

begin
  
  process(CLK_16MS, RST)
    
    variable cnt: natural := 0;
    begin
      if(RST = '1') then
        AN <= "1110";
        cnt := 0;
      elsif(CLK_16MS'event and CLK_16MS = '1') then
        
        case cnt is
          when 0 =>
            AN <= "1110";
          when 1 => 
            AN <= "1101";
          when 2 => 
            AN <= "1011";
          when 3 => 
            AN <= "0111";
          when others =>
            AN <= "1110";
        end case;
        
        cnt := cnt +1;
        if(cnt = 4) then 
          cnt := 0;
        end if;
        
      end if;
      
    end process;
end mac;