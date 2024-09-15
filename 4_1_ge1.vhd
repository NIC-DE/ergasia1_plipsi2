library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity Multiplexer_2to1_8bit is 
Port ( 
DATA0 : in  STD_LOGIC_VECTOR(7 downto 0); 
DATA1 : in  STD_LOGIC_VECTOR(7 downto 0); 
Sel : in  STD_LOGIC; 
Output : out STD_LOGIC_VECTOR(7 downto 0) 
); 
end Multiplexer_2to1_8bit; 
architecture Behavioral of Multiplexer_2to1_8bit is 
begin 
process (DATA0, DATA1, Sel) 
begin 
if Sel = '0' then 
Output <= DATA0; 
else 
Output <= DATA1; 
end if; 
end process; 
end Behavioral;