library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity div_16ms is
  port(
    CLK : in std_logic;
    RST : in std_logic;
    CLK_16MS : out std_logic
  );
end div_16ms;

architecture compteur of div_16ms is

  signal compteur_16ms : std_logic_vector(19 downto 0) := (others => '0'); 
  
  begin
    --compteur_16ms <= (others => '0');  
    process(CLK, RST)
      begin
        if(RST = '1') then
          compteur_16ms <= (others => '0');
        elsif(CLK'event and CLK = '1') then 
          compteur_16ms <= compteur_16ms + '1';
        end if;
      end process;
      
    CLK_16MS <= compteur_16ms(10);
end compteur;

