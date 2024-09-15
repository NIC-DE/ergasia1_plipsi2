library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity ALU is 
Port ( 
op : in  STD_LOGIC_VECTOR(3 downto 0); 
InputA, InputB : in  STD_LOGIC_VECTOR(7 downto 0); 
carryin : in STD_LOGIC; 
carryout : out STD_LOGIC; 
result : out STD_LOGIC_VECTOR(7 downto 0); 
overflow : out STD_LOGIC 
); 
end ALU; 
architecture Behavioral of ALU is 
signal temp_result : STD_LOGIC_VECTOR(8 downto 0);  -- Προσωρινή έξοδος με 
προσθήκη ενός extra bit για υπερχείλιση 

 
 signal temp_carry, temp_ov : STD_LOGIC;  -- Προσωρινά flags carry και 
overflow  
 
begin 
    process (op, InputA, InputB, carryin, temp_result) 
    begin 
        case op is 
            when "0000" => 
                -- Add (A + B) 
                temp_result <= ("0" & InputA) + ("0" & InputB); 
    temp_carry <= temp_result(8); 
    temp_ov <= (temp_result(8) XOR temp_result(7)) XOR (InputA(7) 
XOR InputB(7));     
             
            when "0001" => 
                -- Add with Carry (A + B + Carry) 
                temp_result <= ("0" & InputA) + ("0" & InputB) + ("0" & carryin); 
    temp_carry <= temp_result(8); 
    temp_ov <= (temp_result(8) XOR temp_result(7)) XOR (InputA(7) 
XOR InputB(7));  
             
            when "0010" => 
                -- Subtract (A - B) 
                temp_result <= ("0" & InputA) - ("0" & InputB); 
    temp_carry <= temp_result(8); 
    temp_ov <= (temp_result(8) XOR temp_result(7)) XOR (InputA(7) 
XOR InputB(7)); 
     
            when "0011" => 
                -- Subtract with borrow (A - B - Carry) 
                temp_result <= ("0" & InputA) - ("0" & InputB) - ("0" & carryin); 
    temp_carry <= temp_result(8); 
    temp_ov <= (temp_result(8) XOR temp_result(7)) XOR (InputA(7) 
XOR InputB(7)); 
     
            when "0100" => 
                -- Negative (not A + 00000001) 
                temp_result <= not("0" & InputA) + "00000001"; 
    temp_carry <= '0'; 
    temp_ov <= '0'; 
     
            when "0101" => 
                -- Logical AND (A AND B) 
                temp_result <= ("0" & InputA) AND ("0" & InputB); 
    temp_carry <= '0'; 
    temp_ov <= '0'; 
             
            when "0110" => 
                -- Logical OR (A OR B) 
                temp_result <= ("0" & InputA) OR ("0" & InputB); 
    temp_carry <= '0'; 
    temp_ov <= '0'; 
     
            when "0111" => 
                -- Logical XOR (A XOR B) 
                temp_result <= ("0" & InputA) XOR ("0" & InputB); 
    temp_carry <= '0'; 
    temp_ov <= '0'; 
     
            when "1000" => 
                -- Logical Shift Left (A & "0") 
                temp_result <= InputA & "0"; 
    temp_carry <= temp_result(8); 
 1η Γραπτή Εργασία Εργαστηρίου Ψηφιακών Συστημάτων (ΠΛΗ ΨΙΙ)  
 
11 
 
    temp_ov <= '0'; 
 
            when "1001" => 
                -- Logical Shift Right ("00" & inputA(7 downto 1) 
                temp_result <= "00" & inputA(7 downto 1); 
    temp_carry <= temp_result(0); 
    temp_ov <= '0'; 
 
   when "1010" => 
                -- Pass through (B) 
                temp_result <= ('0' & InputB); 
    temp_carry <= '0'; 
    temp_ov <= '0'; 
 
   when others => 
                temp_result <= "011111111" ; 
    temp_carry <= '0'; 
    temp_ov <= '0'; 
     
        end case; 
  
    end process; 
 
    -- Έξοδος του αποτελέσματος (result) 8 bit 
    result <= temp_result(7 downto 0); 
     -- Έξοδος του κρατουμένου (carryout) 
    carryout <= temp_carry; 
     -- Υπολογίστε την υπερχείλιση (overflow) 
    overflow <= temp_ov; 
  
end Behavioral; 