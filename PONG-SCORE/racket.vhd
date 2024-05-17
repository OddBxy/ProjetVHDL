library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity racket is
  port (
    CLK_25MHZ : in std_logic;
    RST : in std_logic;
    UP : in std_logic;
    DOWN : in std_logic;
    player : in std_logic;    --si 0 -> raquette gauche, s1 1 -> raquette droite
    

    x1 : out integer := 5;
    x2 : out integer := 8;
    y1 : out integer := 208;
    y2 : out integer := 272
    
  );
end racket;

architecture be_a_racket of racket is

signal CLK_DIV : std_logic_vector(15 downto 0) := (others => '0');

signal x1_tmp : integer := 5;
signal y1_tmp : integer := 208;

begin
  
  DIVISEUR : process(CLK_25MHZ, RST)
  begin 
    if(RST = '1') then
      CLK_DIV <= (others => '0');
  		elsif(CLK_25MHZ'event and CLK_25MHZ = '1') then
      CLK_DIV <= CLK_DIV + '1';
    end if;
	end process;
	
	POSITION: process(player)
	begin
	  if(player = '0') then
      x1_tmp <= 5;
	  elsif(player = '1') then
      x1_tmp <= 628;
	  end if;
	end process POSITION;
 
  RAQUETTAGE : process(CLK_DIV(15), UP, DOWN, RST)
  begin
    if(RST = '1') then
      y1_tmp <= 208;
    elsif(CLK_DIV(15)'event and CLK_DIV(15) = '1') then
      if(UP = '1') then
        if(y1_tmp > 2) then 
            y1_tmp <= y1_tmp - 1;
        end if;
      end if;
      
      if(DOWN = '1') then
        if((y1_tmp + 64) < 480) then 
            y1_tmp <= y1_tmp + 1;
        end if;
      end if; 
    end if;
  end process RAQUETTAGE;
  
  x1 <= x1_tmp;
  x2 <= x1_tmp + 8;
  y1 <= y1_tmp;
  y2 <= y1_tmp + 64;
    
end be_a_racket;