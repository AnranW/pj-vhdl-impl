library IEEE; use IEEE.STD_LOGIC_1164.all;
entity mux2 is
	generic(width: integer);
	port(data0, data1: 	in STD_LOGIC_VECTOR(width-1 downto 0);
			sel:			in STD_LOGIC;
			output:			out STD_LOGIC_VECTOR(width-1 downto 0));
end;

architecture behave of mux2 is
begin
	output <= data0 when sel= '0' else data1;
end;