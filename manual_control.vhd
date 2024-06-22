library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity manual_control is 
port(
clk :in std_logic;
ena:in std_logic;
motorx,motory,motorz:out std_logic_vector (3 downto 0);
manual:in std_logic_vector(2 downto 0));
end entity;

architecture logic of manual_control is
signal state:std_logic_vector(30 downto 0);
signal state2:std_logic_vector(2 downto 0);
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
clk_slow<= state(17);
process(clk_slow,ena)
begin
if ena='1' then
if clk_slow'event and clk_slow='1' then
state2<= state2+1;
end if;
end if;
end process;

process(state2)
begin
case manual is
when "000"=> 
	state3x<="0000";
	state3y<="0000";
	state3z<="0000";
when "001"=>
	case state2 is
		when "000"=>state3x<="1100";
		when "001"=>state3x<="0110";
		when "010"=>state3x<="0011";
		when "011"=>state3x<="1001";
		when others=>state3x<=null;
	end case;
when "010"=>
	case state2 is
		when "000"=>state3x<="1001";
		when "001"=>state3x<="0011";
		when "010"=>state3x<="0110";
		when "011"=>state3x<="1100";
		when others=>state3x<=null;
	end case;
when "011"=>
	case state2 is
		when "000"=>state3y<="1100";
		when "001"=>state3y<="0110";
		when "010"=>state3y<="0011";
		when "011"=>state3y<="1001";
		when others=>state3y<=null;
	end case;
when "100"=>
	case state2 is
		when "000"=>state3y<="1001";
		when "001"=>state3y<="0011";
		when "010"=>state3y<="0110";
		when "011"=>state3y<="1100";
		when others=>state3y<=null;
	end case;
when "101"=>
	case state2 is
		when "000"=>state3z<="1100";
		when "001"=>state3z<="0110";
		when "010"=>state3z<="0011";
		when "011"=>state3z<="1001";
		when others=>state3z<=null;
	end case;
when "110"=>
	case state2 is
		when "000"=>state3z<="1001";
		when "001"=>state3z<="0011";
		when "010"=>state3z<="0110";
		when "011"=>state3z<="1100";
		when others=>state3z<=null;
	end case;
when others=>
	state3x<="0000";
	state3y<="0000";
	state3z<="0000";
end case;--case of the nmanual

end process;

motorx<=state3x;
motory<=state3y;
motorz<=state3z;

end logic;