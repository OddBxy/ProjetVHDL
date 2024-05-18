library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity afficheur_4_chiffres is
    port (
            CLK, RST 	    : in std_logic;
            AN              : out std_logic_vector(3 downto 0);
            DIGIT_OUT		: out std_logic_vector(6 downto 0)
    );
end afficheur_4_chiffres;

architecture rtl of afficheur_4_chiffres is
    signal digit: std_logic_vector(6 downto 0);
    

    begin
        AN <= "0000";
        process(CLK, RST)

            begin   
            if(RST = '1') then
                digit <= (others => '1');
            elsif (CLK'event and CLK = '1') then
                digit <= "1000000";  
            end if;
        end process;
        
        DIGIT_OUT <= digit;
end rtl;
