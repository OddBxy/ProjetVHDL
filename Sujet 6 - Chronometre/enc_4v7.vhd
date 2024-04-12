library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity enc_4v7 is
  port(
    NB : in std_logic_vector(3 downto 0);
    SEG : out std_logic_vector(6 downto 0)
  );
end enc_4v7;

architecture enc of enc_4v7 is   --mac pour make a choice

begin
  
  process(NB)
    begin
      
      case NB is
        when "0000" => SEG <= "1000000";
        when "0001" => SEG <= "1111001";
        when "0010" => SEG <= "0100100";
        when "0011" => SEG <= "0110000";
        when "0100" => SEG <= "0011001";
        when "0101" => SEG <= "0010010";
        when "0110" => SEG <= "0000010";
        when "0111" => SEG <= "1111000";
        when "1000" => SEG <= "0000000";
        when "1001" => SEG <= "0010000";
        when others => SEG <= "1000000";
      end case;
      
    end process;
  
end enc;
