library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mux_4v1 is
  port(
    NB1 : in std_logic_vector(3 downto 0);
    NB2 : in std_logic_vector(3 downto 0);
    NB3 : in std_logic_vector(3 downto 0);
    NB4 : in std_logic_vector(3 downto 0);
    AN : in std_logic_vector(3 downto 0);
    OUT_NB : out std_logic_vector(3 downto 0)
  );
end mux_4v1;

architecture mac of mux_4v1 is   --mac pour make a choice

begin
  
  process(AN)
    begin
      
      case AN is
        when "1110" =>
          OUT_NB <= NB1;
        when "1101" => 
          OUT_NB <= NB2;
        when "1011" => 
          OUT_NB <= NB3;
        when "0111" =>
          OUT_NB <= NB4;
        when others =>  OUT_NB <= NB1;
      end case;
      
    end process;
  
end mac;