library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity field is
    port(
        div_25MHZ : in std_logic;
        hcount : in std_logic_vector(10 downto 0);
        vcount : in std_logic_vector(10 downto 0);
        blank : in std_logic;
        RED : out std_logic_vector(3 downto 0) := "0000";
        GREEN : out std_logic_vector(3 downto 0) := "0000";
        BLUE : out std_logic_vector(3 downto 0) := "0000"
    );
  end field;

  architecture display of field is
    begin 
      
      process(div_25MHZ, blank)
        begin 
          if(rising_edge(div_25MHZ)) then
            if(blank = '0') then
                if(hcount >= 318 AND hcount <= 322) then
                    RED <= "1111";
                    GREEN <= "1111";
                    BLUE <= "1111";
                else
                    RED <= "0000";
                    GREEN <= "0000";
                    BLUE <= "0000"; 
                end if; 
            elsif(blank = '1') then
                RED <= "0000";
                GREEN <= "0000";
                BLUE <= "0000";
            end if;
          end if;
        end process;
        
    end display;