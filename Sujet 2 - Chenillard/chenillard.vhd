library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity chenillard is
port (
	CLK,RST : in std_logic;
	L: out std_logic_vector (15 downto 0)
);
end chenillard;


architecture rtl_chenillard of chenillard is
signal state : std_logic_vector(15 downto 0);
signal cnt : std_logic_vector(20 downto 0);

begin
	PROCESS_1 : process (CLK,RST)
	begin
		if (RST = '1') then
		    cnt <= (others => '0');  
		elsif (CLK'event and CLK = '1') then
      cnt <= cnt + '1';
		end if;
	end process;
	
		
	PROCESS_2 : process(cnt(20), RST)
	  	  variable index : integer := 0;
	begin
	  if (RST = '1') then 
	    index := 0;
		  state <= (others => '0');
	  elsif(cnt(20)'event and cnt(20) = '1') then
	     if(index = 16) then
	         index := 0;
	     end if;
	
	     if( state(index) = '1') then
	       state(index) <= '0';
	     elsif(state(index) = '0') then
	       state(index) <= '1';
	     end if;
	     
	     index := index +1;
	  end if;
	end process;
	  
  L <= state;

end rtl_chenillard;
