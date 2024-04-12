library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity div_1s is
  port(
    CLK : in std_logic;
    RST : in std_logic;
    CLK_1S : out std_logic
  );
end div_1s;

architecture compteur of div_1s is

  signal compteur_1s : std_logic_vector(27 downto 0) := (others => '0');
  begin 
    process(CLK, RST)
      begin
        if(RST = '1') then
          compteur_1s <= (others => '0');
        elsif(CLK'event and CLK = '1') then 
          compteur_1s <= compteur_1s + '1';
          if(compteur_1s = x"5F5E0FF") then
            compteur_1s <= (others => '0');
          end if;
        end if;
      end process;
    CLK_1S <= '1' when compteur_1s = x"5F5E0FF" else '0';
end compteur;
