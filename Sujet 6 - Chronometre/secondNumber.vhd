library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity secondNumber is
  port (
    greenFlag : in std_logic;
    div_16ms : in std_logic;
    RST : in std_logic;
    number : out std_logic_vector(3 downto 0) := "0000";
    pass59 : out std_logic := '0'
  );
end secondNumber;

architecture incremente of secondNumber is

  signal nb_binaire : std_logic_vector(3 downto 0) := (others => '0');
  begin
    PROCESS_RST : process(RST, greenFlag, div_16ms) 
      begin 
        
        if(RST = '1') then
          nb_binaire <= (others => '0');
        elsif(greenFlag'event and greenFlag = '1') then
          
          if(nb_binaire = "0101") then
            nb_binaire <= (others => '0');  --pour eviter que ca dépasse 5 en binaire, et que l'on ait + de 59 minutes
            pass59 <= '1';
          else
            nb_binaire <= nb_binaire + '1';
            pass59 <= '0';
          end if;
          
        end if;
        
        if(div_16ms'event and div_16ms = '1') then
          number <= nb_binaire;
        end if;
        
      end process;
    
  end incremente;
