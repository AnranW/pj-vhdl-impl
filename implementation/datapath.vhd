library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.all;
entity datapath is
	port(clk,reset:			in STD_LOGIC;
			memtoreg, pcsrc:	in STD_LOGIC;
			alusrc, regdst:		in STD_LOGIC;
			regwrite, jump:	in STD_LOGIC;
			alucontrol:			in STD_LOGIC_VECTOR(2 downto 0);
			zero:					out STD_LOGIC;
			pc:					buffer STD_LOGIC_VECTOR(31 downto 0);
			instr:				in STD_LOGIC_VECTOR(31 downto 0);
			aluout, writedata: buffer STD_LOGIC_VECTOR(31 downto 0);
			readdata:			in STD_LOGIC_VECTOR(31 downto 0));
end;

architecture struct of datapath is
	component alu
		port(a, b:				in STD_LOGIC_VECTOR(31 downto 0);
				alucontrol:		in STD_LOGIC_VECTOR(2 downto 0);
				result:			out STD_LOGIC_VECTOR(31 downto 0);
				zero:				out STD_LOGIC);
	end component;

	component reg
		port(
		  clk,reset: in std_logic;
		  we: in STD_LOGIC;
		  selA,selB,selIn: in STD_LOGIC_VECTOR(4 downto 0);
		  inputA: in STD_LOGIC_VECTOR(31 downto 0);
		  outputA: out STD_LOGIC_VECTOR(31 downto 0);
		  outputB: out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	signal writereg: STD_LOGIC_VECTOR(4 downto 0);
	signal pcjump, pcnext, pcnextbr, pcplus4, pcbranch: STD_LOGIC_VECTOR(31 downto 0);
	signal signimm, signimmsh: STD_LOGIC_VECTOR(31 downto 0);
	signal srca, srcb, result: STD_LOGIC_VECTOR(31 downto 0);

begin
	pcjump <= pcplus4(31 downto 28) & instr(25 downto 0) & "00";
	pcreg: entity flopr generic map(32) port map(clk, reset, pcnext, pc);
	pcadd1: entity adder port map(pc, X"00000004", pcplus4);
	immsh: entity sl2 port map(signimm, signimmsh);
	pcadd2: entity adder port map(pcplus4, signimmsh, pcbranch);
	pcbrmux: entity mux2 generic map(32) port map(pcplus4, pcbranch, pcsrc, pcnextbr);
	pcmux: entity mux2 generic map(32) port map(pcnextbr, pcjump, jump, pcnext);

	-- register logic
	regfile: reg port map(clk,
								reset,
								regwrite,
								instr(25 downto 21),
								instr(20 downto 16),
								writereg,
								result,
								srca,
								writedata);

	wrmux: entity mux2 generic map(5) port map(instr(20 downto 16), instr(15 downto 11), regdst, writereg);
	resmux: entity mux2 generic map(32) port map(aluout, readdata, memtoreg, result);
	se: entity signext port map(instr(15 downto 0), signimm);

	-- alu logic
	scrbmux: entity mux2 generic map(32) port map(writedata, signimm, alusrc, srcb);
	mainalu: alu port map(srca, srcb, alucontrol, aluout, zero);
end;
