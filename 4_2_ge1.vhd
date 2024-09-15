library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity register_file is 
Port ( 
clk, reset, write : in STD_LOGIC; 
address : in STD_LOGIC_VECTOR(1 downto 0); 
data_in : in STD_LOGIC_VECTOR(7 downto 0); 
address_out1, address_out2 : in STD_LOGIC_VECTOR(1 downto 0); 
data_out1, data_out2 : out STD_LOGIC_VECTOR(7 downto 0) 
); 
end register_file; 
architecture Behavioral of register_file is 
type RegisterArray is array (3 downto 0) of STD_LOGIC_VECTOR(7 downto 0); 
signal registers : RegisterArray := (others => "00000000"); 
begin 
process (clk, reset) 
begin 
if reset = '1' then 
 
registers <= (others => "00000000"); 
elsif rising_edge(clk) then -- Αν η ακμή του ρολογιού είναι ανόδου 
if write = '1' then -- Αν η είσοδος write είναι ενεργή, εγγράψτε τα δεδομένα στον 
επιλεγμένο καταχωρητή 
registers(conv_integer(unsigned(address))) <= data_in; 
end if; 
end if; 
end process; -- Εξόδοι που αντιστοιχούν στα δεδομένα που διαβάστηκαν 
data_out1 <= registers(conv_integer(address_out1)); 
data_out2 <= registers(conv_integer(address_out2)); 
end Behavioral; 