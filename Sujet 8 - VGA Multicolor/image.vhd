library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity image is
  port (
    CLK : in std_logic;
    RST : in std_logic;
    HS : out std_logic;
    VS : out std_logic;
    RED : out std_logic_vector(3 downto 0);
    GREEN : out std_logic_vector(3 downto 0);
    BLUE : out std_logic_vector(3 downto 0)
  );
end image;

architecture behaviour of image is

component div_25MHZ is
  port(
    CLK : in std_logic;
    RST : in std_logic;
    CLK_OUT : out std_logic
  );
end component;  

component vga_controller_640_60 is 
  port(
    rst         : in std_logic;
    pixel_clk   : in std_logic;
    HS          : out std_logic;
    VS          : out std_logic;
    hcount      : out std_logic_vector(10 downto 0);
    vcount      : out std_logic_vector(10 downto 0);
    blank       : out std_logic
  );
end component;

component color is
  port(
    div_25MHZ : in std_logic;
    hcount : in std_logic_vector(10 downto 0);
    vcount : in std_logic_vector(10 downto 0);
    blank : in std_logic;
    RED : out std_logic_vector(3 downto 0);
    GREEN : out std_logic_vector(3 downto 0);
    BLUE : out std_logic_vector(3 downto 0)
  );
end component;

signal CLK_OUT : std_logic := '0';
signal hcount : std_logic_vector(10 downto 0) := (others => '0');
signal vcount : std_logic_vector(10 downto 0) := (others => '0');
signal blank : std_logic :='0';

begin
  
  DUT0 : div_25MHZ port map(CLK, RST, CLK_OUT);
  DUT1 : vga_controller_640_60 port map(RST, CLK_OUT, HS, VS, hcount, vcount, blank);
  DUT2: color port map(CLK_OUT, hcount, vcount, blank, RED, GREEN, BLUE);
  
end behaviour;
  
