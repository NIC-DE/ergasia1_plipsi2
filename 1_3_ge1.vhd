library ieee; 
use ieee. std_logic_1164. all; 
use ieee.std_logic_unsigned.all; 
 
entity RAM is 
    port (  din     : in std_logic_vector (7 downto 0); 
            addr    : in std_logic_vector (7 downto 0); 
            we,clk  : in std_logic; 
            dout    : out std_logic_vector (15 downto 0)); 
end RAM; 
 
architecture arch of RAM is 
signal data_in : std_logic_vector(15 downto 0); 
type vector_array is array (0 to 255) of std_logic_vector (15 
downto 0); 
signal memory: vector_array:=( 
     
     0=>"1010000000101000", --0xA028 
     1=>"0110000000010100", --0x6014 
     2=>"0001000011110000", --0x10F0 
     3=>"1001010000000001", --0x9401 
     4=>"1010000000101001", --0xA029 
     5=>"1000000000000101", --0x8005 
     40=>"0000000001010101", --0x55 
     41=>"0000000011111111", --0xFF  
     others=>"0000000000000000"); 
 
begin 
data_in <= "00000000" & din; --προέκταση σε 16 bits με 8 leading 
zeros 
process (clk) 
begin 
    if rising_edge (clk) then 
        if (we='1') then 
            memory(conv_integer(addr)) <= data_in; 
        end if; 
    end if; 
end process; 
dout <= memory(conv_integer(addr)); 
end arch; 