library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity adder is 
	port(a, b: 	in STD_LOGIC_VECTOR(31 downto 0);
			y:		out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of adder is
begin
	y <= a + b;
end;