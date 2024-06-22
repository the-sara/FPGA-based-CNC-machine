library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnc2 is 
port(
clk :in std_logic;
dirx,diry,dirz:in std_logic;
ena,enax,enay,enaz:in std_logic;
motorx,motory,motorz:out std_logic_vector (3 downto 0));
end entity;

architecture logic of cnc2 is
signal state:std_logic_vector(25 downto 0);
signal state2:std_logic_vector(1 downto 0);
signal state3x,state3y,state3z:std_logic_vector(3 downto 0);	
signal clk_slow:std_logic;
begin
--for the speed controll we need clk divider:
--clk divider:
process(clk)
begin
 if clk'event and clk ='1'then
state<=state+1;
end if;
end process;
clk_slow<= state(18);

process(clk_slow,ena)
begin
if ena='1' then
if clk_slow'event and clk_slow='1' then
state2<= state2+1;
end if;
end if;
end process;

--the x axis
process(state2,dirx,enax)
begin
if enax='1' then
if dirx='1' then
case state2 is         
when "00" => state3x <= "1100";
when "01" => state3x <= "0110";
when "10" => state3x <= "0011";
when "11" => state3x  <= "1001";
when others => null;
end case;
else
case state2 is  
when "00" => state3x <= "1001";
when "01" => state3x <= "0011";
when "10" => state3x <= "0110";
when "11" => state3x  <= "1100";
when others => null;
end case;
end if;
end if;
end process;
motorx<=state3x;

--the y axis:
process(enay,state2,diry)
begin
if enay='1' then
if diry='1' then
case state2 is         
when "00" => state3y <= "1100";
when "01" => state3y <= "0110";
when "10" => state3y <= "0011";
when "11" => state3y  <= "1001";
when others => null;
end case;
else
case state2 is  
when "00" => state3y <= "1001";
when "01" => state3y <= "0011";
when "10" => state3y <= "0110";
when "11" => state3y  <= "1100";
when others => null;
end case;
end if;
end if;
end process;
motory<=state3y;

--the z axis:
process(state2,dirz,enaz)
begin
if enaz='1' then
if dirz='1' then
case state2 is         
when "00" => state3z <= "1100";
when "01" => state3z <= "0110";
when "10" => state3z <= "0011";
when "11" => state3z  <= "1001";
when others => null;
end case;
else
case state2 is  
when "00" => state3z <= "1001";
when "01" => state3z <= "0011";
when "10" => state3z <= "0110";
when "11" => state3z  <= "1100";
when others => null;
end case;
end if;
end if;
end process;
motorz<=state3z;
end logic;
 

 