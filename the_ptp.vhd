library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity the_ptp is 
port(
clk :in std_logic;
rst :in std_logic;
ena:in std_logic;
motorx1,motory1,motorz1:out std_logic_vector (3 downto 0));
end entity;

architecture logic of the_ptp is
signal state:std_logic_vector(30 downto 0);
signal state2:std_logic_vector(2 downto 0);
signal move:std_logic_vector(3 downto 0):="0000";
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
clk_slow2<=state(27);
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
if move < "0011" then
	move<= move+1;
else
	move <= "1111";
end if;
end if;
end if;
else move<="0000";
end if;
end process;
process(state2,move)
begin

--the downing of the z axis:

if move="0000"then
case state2 is         
when "000" => 
state3x <= "0000";
state3y <= "0000";
state3z<="1001";
when "001" =>
 state3x <= "0000";
 state3y <= "0000";
 state3z<="0011";
when "010" =>
 state3x<= "0000";
 state3y <= "0000";
 state3z<="0110";
when "011" => 
state3x  <= "0000";
state3y <= "0000";
state3z<="1100";
when "100" => 
state3x <= "0000";
state3y <= "0000";
state3z<="1001";
when "101" =>
 state3x <= "0000";
 state3y <= "0000";
 state3z<="0011";
when "110" =>
 state3x<= "0000";
 state3y <= "0000";
 state3z<="0110";
when "111" => 
state3x  <= "0000";
state3y <= "0000";
state3z<="1100";
when others => null;
end case;

elsif move="0001" then
case state2 is  
when "000" =>
 state3y <= "1001";
 state3x<= "0000";
 state3z<="0000";
when "001" =>
 state3y <= "0011";
 state3x<= "0000";
when "010" => 
state3y <= "0110";
state3x <= "0000";
state3z<="0000";
when "011" => 
state3y  <= "1100";
state3x <= "0000";
state3z<="0000";
when "100" =>
 state3y <= "1001";
 state3x <= "0000";
 state3z<="0000";
when "101" =>
 state3y <= "0011";
 state3x <= "0000";
 state3z<="0000";
when "110" => 
state3y <= "0110";
state3x <= "0000";
state3z<="0000";
when "111" => 
state3y  <= "1100";
state3x <= "0000";
state3z<="0000";
when others => null;
end case;

elsif move="0010" then
case state2 is         
when "000" => 
state3x <= "0000";
state3y <= "0000";
state3z<="1100";
when "001" =>
 state3x <= "0000";
  state3y <= "0000";
  state3z<="0110";
when "010" =>
 state3x<= "0000";
 state3y<= "0000";
 state3z<="0011";
when "011" => 
state3x  <= "0000";
state3y<= "0000";
state3z<="1100";
when "101" =>
 state3x <= "0000";
  state3y <= "0000";
  state3z<="0110";
when "110" =>
 state3x<= "0000";
 state3y<= "0000";
 state3z<="0011";
when "111" => 
state3x  <= "0000";
state3y<= "0000";
state3z<="1001";
when others => null;
end case;

else
state3x  <= "0000";
state3y<= "0000";
state3z<= "0000";
end if;
end process;

motorx1<=state3x;
motory1<=state3y;
motorz1<=state3z;
end logic;