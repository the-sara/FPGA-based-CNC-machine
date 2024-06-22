library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity the_inter is 
port(
clk :in std_logic;
rst :in std_logic;
ena:in std_logic;
motorx3,motory3,motorz3:out std_logic_vector (3 downto 0));
end entity;

architecture logic of the_inter is
signal state:std_logic_vector(30 downto 0);
signal state2:std_logic_vector(2 downto 0);
signal move_inter:std_logic_vector(3 downto 0):="0000";
signal state3x,state3y,state3z:std_logic_vector(3 downto 0);	
signal clk_slow,clk_slow2:std_logic;
begin
--for the speed controll we need clk divider:
--clk divider:
process(clk)
begin
 if clk'event and clk ='1'then
state<=state+1;
end if;
end process;
clk_slow<= state(16);
clk_slow2<=state(26);
process(clk_slow,ena)
begin
if ena='1' then
if clk_slow'event and clk_slow='1' then
state2<= state2+1;
end if;
end if;
end process;

process(clk_slow2,ena)
begin
if rst='0' then
if ena='1' then
if clk_slow2'event and clk_slow2='1' then
if move_inter < "1000" then
	move_inter<= move_inter+1;
else
	move_inter <= "1111";
end if;
end if;
end if;
else move_inter<="0000";
end if;
end process;
process(state2,move_inter)
begin

--the downing of the z axis:
if move_inter="0000"then
case state2 is         
when "000" => 
state3x <= "0000";
state3y <= "1001";
state3z<="0000";
when "001" =>
 state3x <= "0000";
 state3y <= "0011";
 state3z<="0000";
when "010" =>
 state3x<= "0000";
 state3y <= "0110";
 state3z<="0000";
when "011" => 
state3x  <= "0000";
state3y <= "1100";
when "100" => 
state3x <= "0000";
state3y <= "1001";
state3z<="0000";
when "101" =>
 state3x <= "0000";
 state3y <= "0011";
 state3z<="0000";
when "110" =>
 state3x<= "0000";
 state3y <= "0110";
 state3z<="0000";
when "111" => 
state3x  <= "0000";
state3y <= "1100";
state3z<="0000";
when others => null;
end case;

elsif move_inter="0001" then
case state2 is  
when "000" =>
 state3x <= "1100";
 state3y <= "1001";
 state3z<="0000";
when "001" =>
 state3x <= "0110";
 state3y <= "0011";
 state3z<="0000";
when "010" => 
state3x <= "0011";
state3y <= "0110";
state3z<="0000";
when "011" => 
state3x  <= "1001";
state3y <= "1100";
state3z<="0000";
when "100" =>
 state3x <= "1100";
 state3y <= "1001";
 state3z<="0000";
when "101" =>
 state3x <= "0110";
 state3y <= "0011";
 state3z<="0000";
when "110" => 
state3x <= "0011";
state3y <= "0110";
state3z<="0000";
when "111" => 
state3x  <= "1001";
state3y <= "1100";
state3z<="0000";
when others => null;
end case;

elsif move_inter="0010" then
case state2 is  
when "000" =>
 state3y <= "0000";
 state3x <= "1100";
 state3z<="0000";
when "001" =>
 state3y <= "0000";
 state3x<= "0110";
 state3z<="0000";
when "010" => 
state3y <= "0000";
state3x <= "0011";
state3z<="0000";
when "011" => 
state3y  <= "0000";
state3x <= "1001";
state3z<="0000";
when "100" =>
 state3y <= "0000";
 state3x <= "1100";
 state3z<="0000";
when "101" =>
 state3y <= "0000";
 state3x <= "0110";
 state3z<="0000";
when "110" => 
state3y <= "0000";
state3x <= "0011";
state3z<="0000";
when "111" => 
state3y  <= "0000";
state3x <= "1001";
state3z<="0000";
when others => null;
end case;

elsif move_inter="0011" then
case state2 is  
when "000" =>
 state3y <= "1100";
 state3x <= "1100";
 state3z<="0000";
when "001" =>
 state3y <= "0110";
 state3x <= "0110";
 state3z<="0000";
when "010" => 
state3y <= "0011";
state3x <= "0011";
state3z<="0000";
when "011" => 
state3y  <= "1001";
state3x <= "1001";
state3z<="0000";
when "100" =>
 state3y <= "1100";
 state3x <= "1100";
 state3z<="0000";
when "101" =>
 state3y <= "0110";
 state3x <= "0110";
 state3z<="0000";
when "110" => 
state3y <= "0011";
state3x <= "0011";
state3z<="0000";
when "111" => 
state3y  <= "1001";
state3x <= "1001";
state3z<="0000";
when others => null;
end case;

elsif move_inter="0100" then
case state2 is  
when "000" =>
 state3y <= "1100";
 state3x <= "0000";
 state3z<="0000";
when "001" =>
 state3x <= "0000";
 state3y <= "0110";
 state3z<="0000";
when "010" => 
state3x <= "0000";
state3y <= "0011";
state3z<="0000";
when "011" => 
state3x  <= "0000";
state3y <= "1001";
state3z<="0000";
when "100" =>
 state3x <= "0000";
 state3y <= "1100";
 state3z<="0000";
when "101" =>
 state3x <= "0000";
 state3y <= "0110";
 state3z<="0000";
when "110" => 
state3x <= "0000";
state3y <= "0110";
state3z<="0000";
when "111" => 
state3x  <= "0000";
state3y <= "0110";
state3z<="0000";
when others => null;
end case;

elsif move_inter="0101" then
case state2 is  
when "000" =>
 state3x <= "1001";
 state3y <= "1100";
 state3z<="0000";
when "001" =>
 state3x <= "0011";
 state3y <= "0110";
 state3z<="0000";
when "010" => 
state3x <= "0110";
state3y <= "0011";
state3z<="0000";
when "011" => 
state3x  <= "1100";
state3y <= "1001";
state3z<="0000";
when "100" =>
 state3x <= "1001";
 state3y <= "1100";
 state3z<="0000";
when "101" =>
 state3x <= "0011";
 state3y <= "0110";
 state3z<="0000";
when "110" => 
state3x <= "0110";
state3y <= "0011";
state3z<="0000";
when "111" => 
state3x  <= "1100";
state3y <= "1001";
state3z<="0000";
when others => null;
end case;


elsif move_inter="0110" then
case state2 is         
when "000" => 
 state3x <= "1001";
 state3y <= "0000";
 state3z<="0000";
when "001" =>
 state3x <= "0011";
  state3y <= "0000";
  state3z<="0000";
when "010" =>
 state3x<= "0110";
 state3y<= "0000";
 state3z<="0000";
when "011" => 
state3x  <= "1100";
state3y<= "0000";
state3z<="0000";
when "100" =>
 state3x <= "1001";
  state3y <= "0000";
  state3z<="0000";
when "101" =>
 state3x<= "0011";
 state3y<= "0000";
 state3z<="0000";
when "110" => 
state3x  <= "0110";
state3y<= "0000";
state3z<="0000";
when "111" => 
state3x  <= "1100";
state3y<= "0000";
state3z<="0000";
when others => null;
end case;

elsif move_inter="0111" then
case state2 is  
when "000" =>
 state3x <= "1001";
 state3y<= "1001";
 state3z<="0000";
when "001" =>
 state3x <= "0011";
 state3y<= "0011";
 state3z<="0000";
when "010" => 
state3x <= "0110";
state3y<= "0110";
state3z<="0000";
when "011" => 
state3x  <= "1100";
state3y<= "1100";
state3z<="0000";
when "100" =>
 state3x <= "1001";
 state3y<= "1001";
 state3z<="0000";
when "101" =>
 state3x <= "0011";
 state3y<= "0011";
 state3z<="0000";
when "110" => 
state3x <= "0110";
state3y<= "0110";
state3z<="0000";
when "111" => 
state3x <= "1100";
state3y<= "1100";
state3z<="0000";

when others => null;
end case;

else
state3x  <= "0000";
state3y<= "0000";
state3z<= "0000";
end if;
end process;

motorx3<=state3x;
motory3<=state3y;
motorz3<=state3z;
end logic;