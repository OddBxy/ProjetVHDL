library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity cnt_incremental_led is
    port (
           CLK, RST, MORE, LESS 	: in std_logic;
           LED			: out std_logic_vector(15 downto 0)
    );
end cnt_incremental_led; 

architecture rtl of cnt_incremental_led is
signal diviseur : std_logic_vector(24 downto 0);
signal state: std_logic_vector(15 downto 0);
begin



	PROCESS_1 : process (CLK,RST)
	begin
		if(CLK'event and CLK = '1') then
            diviseur <= diviseur + '1';
		end if;
	end process;


    PROCESS_2 : process(diviseur(24), RST, MORE, LESS)
        variable index: integer:= 0;
        
        begin
        if(diviseur(24)'event AND diviseur(24) = '1') then
        
            if(RST = '1') then
                index := 0;
                state <= (others => '0');
    
            elsif(MORE = '1') then
            
                state(index) <= '1';
                index:=index + 1;
                if(index > 16) then
                    index:= 16;
                end if;
            
            elsif(LESS = '1') then
            
                state(index) <= '0';
                index:= index - 1;
                if(index < 0 ) then
                    index:= 0;
                end if;
                
            end if;
            
            end if;
       
    end process;
    LED <= state;
end rtl;
