library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity racket is
  port (
    CLK : in std_logic;
    RST : in std_logic;
    UP : in std_logic;
    DOWN : in std_logic;
    player : in std_logic;    --si 0 -> raquette gauche, s1 1 -> raquette droite
    
    
    x1 : out std_logic_vector(10 downto 0) := "00000000000";    
    y1 : out std_logic_vector(10 downto 0) := "00011010001";
    x2 : out std_logic_vector(10 downto 0) := "00000001000";
    y2 : out std_logic_vector(10 downto 0) := "00100010000"
  );
end racket;

architecture be_a_racket of racket is

signal CLK_DIV : std_logic_vector(24 downto 0) := (others => '0');

signal x1_tmp : std_logic_vector(10 downto 0) := "00000000000";
signal y1_tmp : std_logic_vector(10 downto 0) := "00011010001";

begin
  
  DIVISEUR : process(CLK, RST)
  begin 
    if(RST = '1') then
      CLK_DIV <= (others => '0');
      y1_tmp <= "00011010001";
  		elsif(CLK'event and CLK = '1') then
      CLK_DIV <= CLK_DIV + '1';
    end if;
	end process;
	
	POSITION: process(player)
	begin
	  if(player = '0') then
      x1_tmp <= "00000000000";
	  elsif(player = '1') then
      x1_tmp <= "00101000000";
	  end if;
	end process POSITION;
 
  RAQUETTAGE : process(CLK_DIV(24), UP, DOWN)
  begin
    if(CLK_DIV(24)'event and CLK_DIV(24) = '1') then
      if(UP = '1') then
        y1_tmp <= y1_tmp + '1';
      end if;
      
      if(DOWN = '1') then
        y1_tmp <= y1_tmp - '1';
      end if; 
    end if;
  end process RAQUETTAGE;
  
  x1 <= x1_tmp;
  x2 <= x1_tmp + "00000001000";
  y1 <= y1_tmp;
  y2 <= y1_tmp + "00001000000";
    
end be_a_racket;
