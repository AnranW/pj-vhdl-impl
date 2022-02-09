library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.numeric_std.all;

entity dmem is
	port(clk, we:	in STD_LOGIC;
			a, wd:	in STD_LOGIC_VECTOR(31 downto 0);
			rd:		out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of dmem is
	type ramtype is array(4095 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
	signal mem: ramtype;
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we = '1') then 
				mem(to_integer(unsigned(a(13 downto 2))))<= wd;
			end if;
		end if;
	end process;
	process(a)
	begin
		if unsigned(a) < 4095 then
			rd <= mem(to_integer(unsigned(a(13 downto 2))));
		else
			rd <= X"BEEFDEAD";
		end if;
	end process;
end;