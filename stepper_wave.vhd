library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity stepper_wave is 
port(
clk :in std_logic;
dir:in std_logic;
ena:in std_logic;
motor , q :out std_logic_vector (3 downto 0));
end entity;

architecture logic of stepper_wave is
signal state:std_logic_vector(25 downto 0);
signal state2:std_logic_vector(1 downto 0);
signal state3:std_logic_vector(3 downto 0);	
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
clk_slow<= state(19);
process(clk_slow,ena)

begin
if ena='1' then
if clk_slow'event and clk_slow='1' then

state2<= state2+1;


end if;
end if;
end process;
process(state2,dir)
begin
if dir='1' then
case state2 is         
when "00" => state3 <= "1100";
when "01" => state3 <= "0110";
when "10" => state3 <= "0011";
when "11" => state3  <= "1001";
when others => null;
end case;
else

case state2 is  
when "00" => state3 <= "1001";
when "01" => state3 <= "0011";
when "10" => state3 <= "0110";
when "11" => state3  <= "1100";
when others => null;
end case;
end if;
end process;
motor<=state3;
q<=state3;
end logic;
 

 
