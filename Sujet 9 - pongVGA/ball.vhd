library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ball is
    port(
        CLK_25MHZ : in std_logic;
        RST : in std_logic;
        sens: in std_logic_vector(1 downto 0);
        speed: out integer;
        x1: inout integer;
        y1: inout integer;
        x2: inout integer;
        y2: inout integer
    );
end ball;

architecture be_a_ball of ball is

    signal CLK_DIV : std_logic_vector(23 downto 0) := (others => '0');
    
    begin
      
      DIVISEUR : process(CLK_25MHZ, RST)
      begin 
        if(RST = '1') then
          CLK_DIV <= (others => '0');
              elsif(CLK_25MHZ'event and CLK_25MHZ = '1') then
          CLK_DIV <= CLK_DIV + '1';
        end if;
      end process;
     
    BALLAGE : process(CLK_DIV(23), speed, RST)
    begin
        if(RST = '1') then
            x_tmp <= 320;
            y_tmp <= 240;
        elsif(CLK_DIV(23)'event and CLK_DIV(23) = '1') then
            case sens is
            when "00" => 
                x_tmp <= x1 + speed; 
                y_tmp <= y1 + speed;
            when "01" =>
                x_tmp <= x1 + speed; 
                y_tmp <= y1 - speed;
            when "10" =>
                x_tmp <= x1 - speed; 
                y_tmp <= y1 + speed;
            when "11" =>
                x_tmp <= x1 - speed; 
                y_tmp <= y1 - speed;
            end case;
        end if;
    end process BALLAGE;
      
    x1 <= x_tmp;
    x2 <= x_tmp + 4; 
    y1 <= y_tmp;
    y2 <= y_tmp + 4;
        
end be_a_ball;