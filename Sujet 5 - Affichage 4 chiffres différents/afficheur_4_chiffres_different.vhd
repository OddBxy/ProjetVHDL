library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity afficheur_4_chiffres is
    port (
            CLK, RST     : in std_logic;
            AN              : out std_logic_vector(3 downto 0);
            DIGIT_OUT: out std_logic_vector(6 downto 0)
    );
end afficheur_4_chiffres;

architecture rtl of afficheur_4_chiffres is
    signal diviseur: std_logic_vector(18 downto 0);
    signal digit: std_logic_vector(6 downto 0);
    

    begin
        PROCESS_1 : process(CLK,RST)
          begin
            if(RST = '1') then
              diviseur <= (others => '0');
            elsif(CLK'event and CLK = '1') then
              diviseur <= diviseur + '1';
            end if;
          end process;       
          
        PROCESS_2 : process(diviseur(18) , RST)
        variable cnt: natural range 0 to 3 := 0;
            begin   
            if(RST = '1') then
                digit <= (others => '1');
            elsif (diviseur(18)'event and diviseur(18) = '1') then
                cnt := cnt + 1;
               
                case cnt is
                  when 0 =>
                    AN <= "0111";
                    digit <= "1000000";
                  when 1 => 
                    AN <= "1011";
                    digit <= "1111001";
                  when 2 => 
                    AN <= "1101";
                    digit <= "0100100";
                  when 3 => 
                    AN <= "1110";
                    digit <= "0110000";
                end case;
            end if;
        end process;
        DIGIT_OUT <= digit;
end rtl;
