-- Declaration of 32-bit register, used for program counter, instruction register, general registers, etc.
library ieee;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

entity reg is
port(
  clk,reset: in std_logic;
  we: in STD_LOGIC;
  selA,selB,selIn: in STD_LOGIC_VECTOR(4 downto 0);
  inputA: in STD_LOGIC_VECTOR(31 downto 0);
  outputA: out STD_LOGIC_VECTOR(31 downto 0);
  outputB: out STD_LOGIC_VECTOR(31 downto 0));
end reg;

architecture behaviour of reg is
	type regBankTy is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);

  signal reg: regBankTy := (others=>(others=>'0'));
begin

  process (clk)
    begin
      if rising_edge(clk) then
        if we = '1' then -- write to register
          reg(to_integer(unsigned(selIn))) <= inputA;
        end if;
      end if;
    end process;

    -- read from register 
    outputA <= reg(to_integer(unsigned(selA)));
    outputB <= reg(to_integer(unsigned(selB)));

end architecture;
