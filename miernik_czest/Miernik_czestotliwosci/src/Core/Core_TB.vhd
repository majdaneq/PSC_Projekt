																library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity core_tb is
end core_tb;

architecture TB_ARCHITECTURE of core_tb is
	-- Component declaration of the tested unit
	component core
	port(	
	LE:in STD_LOGIC;
	Ylatch:inout STD_LOGIC_vector(3 downto 0) := "0000";
	fx:in STD_logic;   					 --mierzony sygnal		 
	fautomat: in STD_LOGIC;	
	CLR:in STD_LOGIC;	
	Yx:inout STD_LOGIC_vector(2 downto 0) := "000";
	CE:inout STD_LOGIC :='0';   
	Yautomat: inout STD_LOGIC;  		 --GATE/CE dla licznik�w
	Y:inout STD_LOGIC_vector(3 downto 0) :="0000";	 --wyjscie licznikow dekadowych
	CLK:in STD_logic			  
		); 									
	end component; 
	


	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	--signal SEL: STD_LOGIC;
	signal fx: STD_LOGIC;
	signal fautomat: STD_LOGIC;
	signal CLR: STD_LOGIC;
	signal CE: STD_LOGIC;
	signal Yautomat : STD_LOGIC;
	signal CLK : STD_LOGIC;
	signal LE : STD_LOGIC;	
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Y : STD_LOGIC_VECTOR(3 downto 0); --zad4
	signal Yx: STD_LOGIC_vector(2 downto 0);  
	signal Ylatch : STD_LOGIC_VECTOR(3 downto 0);
	--Signal is used to stop clock signal generators
	signal END_SIM: BOOLEAN:=FALSE;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : core
	port map ( 	
			Ylatch=>Ylatch,
			LE=>LE,
			fx=>fx,		
			Yx=>Yx,
			fautomat=>fautomat,
			CLR=>CLR,
			CE=>CE,		
			Yautomat=>Yautomat,	 			
			CLK => CLK,
			Y => Y	 			
		); 
		
		
	--Below VHDL code is an inserted .\compile\Initial.vhs
	--User can modify it ....

STIMULUS: process
begin  -- of stimulus process
--wait for <time to next event>; -- <current time> 
	--CE<='1';
	CLR<='0';  		
	wait for 200 ns;
	LE<='1';
	wait for 100 ns;
	LE<='0'; 
	wait for 100 ns;
	LE<='1';
	wait for 1000ns;
	LE<='0';
	wait for 1000ns;
	END_SIM <= TRUE;
	
	
--	end of stimulus events
	wait;
end process; -- end of stimulus process
	
CLOCK_CLK : process
begin
	--this process was generated based on formula: 0 0 ns, 1 50 ns -r 100 ns
	--wait for <time to next event>; -- <current time>
	if END_SIM = FALSE then
		CLK <= '0';
		wait for 50 ns; --0 fs
	else
		wait;
	end if;
	if END_SIM = FALSE then
		CLK <= '1';
		wait for 50 ns; --50 ns
	else
		wait;
	end if;
end process;




	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_core of core_tb is
	for TB_ARCHITECTURE
		for UUT : core
			use entity work.core(core);
		end for;
	end for;
end TESTBENCH_FOR_core;
