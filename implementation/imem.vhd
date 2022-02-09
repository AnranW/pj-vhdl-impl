library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use ieee.numeric_std.all;

entity imem is
	port(a: in STD_LOGIC_VECTOR(5 downto 0);
			rd: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of imem is

		type rom_t is array(0 to 17) of STD_LOGIC_VECTOR(31 downto 0);
		-- Read a *.hex file
impure function ocram_ReadMemFile(FileName : STRING) return rom_t is
  file FileHandle       : TEXT open READ_MODE is FileName;
  variable CurrentLine  : LINE;
  variable TempWord     : STD_LOGIC_VECTOR(31 downto 0);
  variable Result       : rom_t    := (others => (others => '0'));

begin
  for i in 0 to 17 loop
    exit when endfile(FileHandle);

    readline(FileHandle, CurrentLine);
    --hread(CurrentLine, TempWord);
    Result(i)    := TempWord;
  end loop;

  return Result;
end function;
constant mem: rom_t:=(
			X"20020005",
			X"2003000c",
			X"2067fff7",
			X"00e22025",
			X"00642824",
			X"00a42820",
			X"10a7000a",
			X"0064202a",
			X"10800001",
			X"20050000",
			X"00e2202a",
			X"00853820",
			X"00e23822",
			X"ac670044",
			X"8c020050",
			X"08000011",
			X"20020001",
			X"ac020054"
		);
	--signal mem: rom_t := ocram_ReadMemFile("memfile.dat");
begin
	process(a) is
--		file mem_file: TEXT;
--		variable L: line;
--		variable ch: character;
--		variable index, result: integer;
--		type ramtype is array(63 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
--		variable mem: ramtype;
	begin
--		for i in 0 to 63 loop
--			mem(conv_integer(i)) := CONV_STD_LOGIC_VECTOR(0, 32);
--		end  loop;
--		index := 0;
--		FILE_OPEN(mem_file, "C:/Users/Jasper/Development/single-cycle/memfile.dat", READ_MODE);
--		while not endfile(mem_file) loop
--			readline(mem_file, L);
--			result := 0;
--			for i in 1 to 8 loop
--				read(l, ch);
--				if '0' <= ch and ch <= '9' then
--					result := result * 16 + character'pos(ch) - character'pos('0');
--				elsif 'a' <= ch and ch <= 'f' then
--					result := result*16 + character'pos(ch) - character'pos('a') + 10;
--				else report "Format error on line " & integer'image(index) severity error;
--				end if;
--			end loop;
--			mem(index) := CONV_STD_LOGIC_VECTOR(result, 32);
--			index := index + 1;
--		end loop;

		-- read memory
--		loop
			rd <= mem(to_integer(unsigned(a)));
--			wait on a;
--		end loop;
	end process;
end;
