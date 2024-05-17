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
        
        UP1 : in std_logic;
        UP2 : in std_logic;
        DOWN1 : in std_logic;
        DOWN2 : in std_logic;
        
        RST : in std_logic;
        
        RED : out std_logic_vector(3 downto 0) := "0000";
        GREEN : out std_logic_vector(3 downto 0) := "0000";
        BLUE : out std_logic_vector(3 downto 0) := "0000"
    );
  end field;

architecture display of field is
  
component racket is
  port (
    CLK_25MHZ : in std_logic;
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

component ball is
  port(
    CLK_25MHZ : in std_logic;
    RST : in std_logic;
    sens: in std_logic_vector(1 downto 0);
    speed: in integer;
    x1: inout integer := 318;
    y1: inout integer := 238;
    x2: inout integer;
    y2: inout integer
  );
end component;

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

signal xballe1 : integer;
signal xballe2 : integer;
signal yballe1 : integer;
signal yballe2 : integer;
signal RST_BALL : std_logic := '0';

signal sens : std_logic_vector(1 downto 0) := "00";
signal speed : integer := 1;   
signal RST_HANDLER : std_logic := '0';  
signal RST_COLLISION : std_logic := '0';

signal scorep0 : integer := 0;
signal scorep1 : integer := 0;
--a cause du fpga, on ne peut pas gérer un signaux dans plusieurs process, or on veut gérer la position de la balle et sa vitesse si le bouton rst est appuyé ou si un joueur marque
-- problème : il y a donc plusieurs process qui essaient de gérer la vitesse de la balle ainsi que sa position
--solution : on sait que l'on doit reset la balle si un joueur marque, et si on appuie sur le bouton reset :
--donc le process des collision renvoie un signal lorsqu'un joueur marque, qui est envoyé a un process qui gère ce signal ainsi que celui du bouton reset
--celui ci renvoie un signal qui peut être interpreter par un dernier process afin de gérer la position et la vitesse de la balle 

begin 
  
  RACKET1 : racket port map(
    CLK_25MHZ => div_25MHZ, 
    RST => RST, 
    UP => UP1, 
    DOWN => DOWN1, 
    player => player0, 
    x1 => x1, 
    x2 => x2, 
    y1 => y1, 
    y2 => y2
  );
  
  RACKET2 : racket port map(
    CLK_25MHZ => div_25MHZ, 
    RST => RST, 
    UP => UP2, 
    DOWN => DOWN2, 
    player => player1, 
    x1 => x3, 
    x2 => x4, 
    y1 => y3, 
    y2 => y4
  );

  BALL1 : ball port map(
    CLK_25MHZ => div_25MHZ, 
    RST => RST_BALL,
    sens => sens,
    speed => speed,
    x1 => xballe1, 
    x2 => xballe2, 
    y1 => yballe1, 
    y2 => yballe2
  );
      
  AFFICHAGE: process(div_25MHZ, blank)
    begin 
      if(rising_edge(div_25MHZ)) then
        if(blank = '0') then
          if(hcount <= 2 OR hcount >= 638) then
            RED <= "1111";
            GREEN <= "1111";
            BLUE <= "1111";
          elsif(vcount <= 2 OR vcount >= 478) then
            RED <= "1111";
            GREEN <= "1111";
            BLUE <= "1111";
          elsif(hcount >= 318 AND hcount <= 322) then
            RED <= "1111";
            GREEN <= "1111";
            BLUE <= "1111";
          elsif(hcount >= x1 and hcount <= x2 and vcount >= y1 and vcount <= y2) then
            RED <= "1111";
            GREEN <= "0000";
            BLUE <= "1111";
          elsif(hcount >= x3 and hcount <= x4 and vcount >= y3 and vcount <= y4) then
            RED <= "0000";
            GREEN <= "1111";
            BLUE <= "1111";
          elsif(hcount >= xballe1 and hcount <= xballe2 and vcount >=  yballe1 and vcount <= yballe2) then
            RED <= "1111";
            GREEN <= "0000";
            BLUE <= "0000";
          -- score player 0
          elsif(hcount >= 150 and hcount <= 180 and vcount >= 10 and vcount <= 40) then
            case scorep0 is
              when 0 =>
                if (hcount >= 150 and hcount <= 180 and vcount >= 10 and vcount <= 12) or
                   (hcount >= 150 and hcount <= 152 and vcount >= 10 and vcount <= 40) or
                   (hcount >= 150 and hcount <= 180 and vcount >= 38 and vcount <= 40) or
                   (hcount >= 178 and hcount <= 180 and vcount >= 10 and vcount <= 40) then
                  RED <= "0000";
                  GREEN <= "1111";
                  BLUE <= "1111";
                else
                  RED <= "0000";
                  GREEN <= "0000";
                  BLUE <= "0000";
                end if;
              when 1 =>
                if (hcount >= 165 and hcount <= 180 and vcount >= 10 and vcount <= 12) or
                   (hcount >= 176 and hcount <= 180 and vcount >= 12 and vcount <= 40) then
                  RED <= "0000";
                  GREEN <= "1111";
                  BLUE <= "1111";
                else
                  RED <= "0000";
                  GREEN <= "0000";
                  BLUE <= "0000";
                end if;
              when others =>
                 RED <= "0000";
                  GREEN <= "0000";
                  BLUE <= "0000";
            end case;
          -- score player 1
          elsif(hcount >= 480 and hcount <= 510 and vcount >= 10 and vcount <= 40)  then
            case scorep1 is
              when 0 =>
                if (hcount >= 480 and hcount <= 510 and vcount >= 10 and vcount <= 12) or
                   (hcount >= 480 and hcount <= 482 and vcount >= 10 and vcount <= 40) or
                   (hcount >= 480 and hcount <= 510 and vcount >= 38 and vcount <= 40) or
                   (hcount >= 508 and hcount <= 510 and vcount >= 10 and vcount <= 40) then
                  RED <= "0000";
                  GREEN <= "1111";
                  BLUE <= "1111";
                else
                  RED <= "0000";
                  GREEN <= "0000";
                  BLUE <= "0000";
                end if;
              when 1 =>
                if (hcount >= 495 and hcount <= 510 and vcount >= 10 and vcount <= 12) or
                   (hcount >= 506 and hcount <= 510 and vcount >= 12 and vcount <= 40) then
                  RED <= "0000";
                  GREEN <= "1111";
                  BLUE <= "1111";
                else
                  RED <= "0000";
                  GREEN <= "0000";
                  BLUE <= "0000";
                end if;
              when others =>
                 RED <= "0000";
                  GREEN <= "0000";
                  BLUE <= "0000";
            end case;
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
  

  COLLISION_BORDS: process(div_25MHZ, RST,xballe1, xballe2, yballe1, yballe2)
    begin
      if(RST = '1') then
          scorep0 <= 0;
          scorep1 <= 0;  
      elsif(rising_edge(div_25MHZ)) then
        
        if(yballe1 <= 2) then
          sens(0) <= '0';
        elsif(yballe2 >= 478) then
          sens(0) <= '1';
        end if;
        
        --condition pour le score et le reset
        if(xballe1 <= 2) then
          scorep1 <= scorep1 + 1;
          RST_COLLISION <= '1';
          RST_BALL <= '1';
        elsif(xballe2 >= 638) then
          scorep0 <= scorep0 + 1;
          RST_COLLISION <= '1';
          RST_BALL <= '1';
        else       
          RST_COLLISION <= '0';
          RST_BALL <= '0';
        end if;
        
      end if;
    end process;
    
    
  GESTION_RST: process(RST, RST_COLLISION)
    begin 
      if(RST = '1') then
        RST_HANDLER <= '1';
      elsif(RST_COLLISION = '1') then  
        RST_HANDLER <= '1';
      else
        RST_HANDLER <= '0';
      end if;
    end process;
      
      
  COLLISION_RAQUETTES: process(div_25MHZ, RST_HANDLER, xballe1, xballe2, yballe1, yballe2)
    begin
      if(RST_HANDLER = '1') then
        speed <= 1;
        sens(1) <= not sens(1);

        
      elsif(rising_edge(div_25MHZ)) then
        
        if(xballe1 <= x2 AND yballe1 >= y1 AND yballe2 <= y2) then
          sens(1) <= '0';
          --speed <= speed + 1;
        elsif(xballe2 >= x3 AND yballe2 >= y3 AND yballe2 <= y4) then
          sens(1) <= '1';
          --speed <= speed + 1;
        end if;
        
      end if;
    end process;
end;