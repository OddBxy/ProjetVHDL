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
  
component racket is
  port (
    CLK : in std_logic;
    RST : in std_logic;
    UP : in std_logic;
    DOWN : in std_logic;
    player : in std_logic;    --si 0 -> raquette gauche, s1 1 -> raquette droite
    
    x1 : out integer := 0;
    x2 : out integer := 8;
    y1 : out integer := 288;
    y2 : out integer := 352
  );
end component;

signal RST : std_logic := '0';
signal UP : std_logic := '0';
signal DOWN : std_logic := '0';
signal player0 : std_logic := '0';
signal player1 : std_logic := '1';

signal x1 : integer;
signal x2 : integer;
signal y1 : integer;
signal y2 : integer;

signal x3 : integer;
signal x4 : integer;
signal y3 : integer;
signal y4 : integer;

begin 
  
  RACKET1 : racket port map(div_25MHZ, RST, UP, DOWN, player0, x1, x2, y1, y2);
  RACKET2 : racket port map(div_25MHZ, RST, UP, DOWN, player1, x3, x4, y3, y4);
      
  process(div_25MHZ, blank)
    begin 
      if(rising_edge(div_25MHZ)) then
        if(blank = '0') then
          if(hcount >= 318 AND hcount <= 322) then
            RED <= "1111";
            GREEN <= "1111";
            BLUE <= "1111";
          elsif(hcount >= x1 and hcount <= x2 and vcount >= y1 and vcount <= y2) then
            RED <= "1111";
            GREEN <= "1111";
            BLUE <= "1111";
          elsif(hcount >= x3 and hcount <= x4 and vcount >= y3 and vcount <= y4) then
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
