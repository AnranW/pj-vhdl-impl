library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.numeric_std.all;
entity alu is
	port (a, b:			in STD_LOGIC_VECTOR(31 downto 0);
			alucontrol: in STD_LOGIC_VECTOR(2 downto 0);
			result: 		buffer STD_LOGIC_VECTOR(31 downto 0);
			zero:			out STD_LOGIC);
end;

architecture behave of alu is

begin
	process (alucontrol, a, b) begin
		case alucontrol is
			when "010" => result <= STD_LOGIC_VECTOR(signed(a) + signed(b)); -- TODO: signed, unsigned????
			when "110" => result <= STD_LOGIC_VECTOR(signed(a) - signed(b));
			when "000" => result <= a and b;
			when "001" => result <= a or b;
			when "111" => 
				if(signed(a) < signed(b)) then 
					result <= X"00000001";
				else 
					result <= X"00000000";
				end if;
			when others => result <= X"DEADBEEF";
		end case;
	end process;
   zero <= '1' when result = X"00000000" else '0';
end;