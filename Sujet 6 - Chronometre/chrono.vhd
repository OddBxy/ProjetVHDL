library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity chrono is
  port(
    CLK : in std_logic;
    RST : in std_logic;
    SEG : out std_logic_vector (6 downto 0);
    AN : out std_logic_vector(3 downto 0)
  );
end chrono;

architecture compte of chrono is

component div_1s
  port (
    CLK: in std_logic;
    RST : in std_logic;
    CLK_1S : out std_logic
    );
end component;

component div_16ms
    port(
    CLK : in std_logic;
    RST : in std_logic;
    CLK_16MS : out std_logic
  );
end component;

component firstNumber
  port (
    greenFlag : in std_logic;
    div_16ms : in std_logic;
    RST : in std_logic;
    number : out std_logic_vector(3 downto 0);
    pass9 : out std_logic
  );
end component;

component secondNumber
  port (
    greenFlag : in std_logic;
    div_16ms : in std_logic;
    RST : in std_logic;
    number : out std_logic_vector(3 downto 0);
    pass59 : out std_logic
  );
end component;

component an_selector
    port(
    CLK_16MS : in std_logic;
    RST : in std_logic;
    AN : out std_logic_vector
  );
end component;

component mux_4v1
  port(
    NB1 : in std_logic_vector(3 downto 0);
    NB2 : in std_logic_vector(3 downto 0);
    NB3 : in std_logic_vector(3 downto 0);
    NB4 : in std_logic_vector(3 downto 0);
    AN : in std_logic_vector(3 downto 0);
    OUT_NB : out std_logic_vector(3 downto 0)
  );
end component;

component enc_4v7
  port(
    NB : in std_logic_vector(3 downto 0);
    SEG : out std_logic_vector(6 downto 0)
  );
end component;

signal CLK_1S : std_logic;
signal CLK_16MS : std_logic;

signal outNb1 : std_logic_vector(3 downto 0);
signal GF_1 : std_logic := '0'; --GF pour green flag, il passe a 1 quand on atteint 9

signal outNb2 : std_logic_vector(3 downto 0);
signal GF_2 : std_logic := '0'; --GF pour green flag, il passe a 1 quand on atteint 59

signal outNb3 : std_logic_vector(3 downto 0);
signal GF_3 : std_logic := '0'; --GF pour green flag, il passe a 1 quand on atteint 9

signal outNb4 : std_logic_vector(3 downto 0);
signal GF_4 : std_logic := '0';   --GF pour green flag, il passe a 1 quand on atteint 59


signal AN_OUT : std_logic_vector(3 downto 0);
signal NB_OUT : std_logic_vector(3 downto 0);
signal SEG_OUT : std_logic_vector(6 downto 0);

begin
    
  CPS0 : div_1s port map(CLK, RST, CLK_1S);
  CPS1 : div_16ms port map(CLK, RST, CLK_16MS);
  CPS2 : firstNumber port map(CLK_1S, CLK_16MS, RST, outNb1, GF_1);
  CPS3 : secondNumber port map(GF_1, CLK_16MS, RST, outNb2, GF_2);
  CPS4 : firstNumber port map(GF_2, CLK_16MS, RST, outNb3, GF_3);
  CPS5 : secondNumber port map(GF_3, CLK_16MS, RST, outNb4, GF_4);
  
  SLCT : an_selector port map(CLK_16MS, RST, AN_OUT);
  MUX : mux_4v1 port map(outNb1, outNb2, outNb3, outNb4, AN_OUT, NB_OUT);
  ENC : enc_4v7 port map(NB_OUT, SEG_OUT);

        
  AN <= AN_OUT;
  SEG <= SEG_OUT;
end compte;



