library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
 
entity ALU_TB is 
end ALU_TB; 
 
architecture Behavioral of ALU_TB is 
    -- Component declaration 
    component ALU is 
        Port ( 
            op : in  STD_LOGIC_VECTOR(3 downto 0); 
            InputA, InputB : in  STD_LOGIC_VECTOR(7 downto 0); 
            carryin : in STD_LOGIC; 
            carryout : out STD_LOGIC; 
            result : out STD_LOGIC_VECTOR(7 downto 0); 
            overflow : out STD_LOGIC 
        ); 
    end component; 
 
    -- Signal declaration 
   
  
 
    signal op: STD_LOGIC_VECTOR(3 downto 0) := "0000"; 
    signal InputA: STD_LOGIC_VECTOR(7 downto 0) := "00110111"; -- 55 in 
binary 
    signal InputB: STD_LOGIC_VECTOR(7 downto 0) := "00100100"; -- 36 in 
binary 
    signal carryin: STD_LOGIC := '0'; 
    signal carryout: STD_LOGIC; 
    signal result: STD_LOGIC_VECTOR(7 downto 0); 
    signal overflow: STD_LOGIC; 
 
begin 
    -- Instantiate the ALU component 
    uut: ALU port map ( 
        op => op, 
        InputA => InputA, 
        InputB => InputB, 
        carryin => carryin, 
        carryout => carryout, 
        result => result, 
        overflow => overflow 
    ); 
 
    -- Stimulus process 
    process 
    begin 
        -- Test Add (A + B) 
        op <= "0000"; -- Add (A + B) 
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test Add with Carry (A + B + Carry) 
        op <= "0001"; -- Add with Carry (A + B + Carry) 
        carryin <= '1'; 
        wait for 10 ns; 
        -- Test Subtract (A - B) 
        op <= "0010"; -- Subtract (A - B) 
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test Subtract with borrow (A - B - Carry) 
        op <= "0011"; -- Subtract with borrow (A - B - Carry) 
        carryin <= '1'; 
        wait for 10 ns; 
        -- Test Negative (not A + 00000001) 
        op <= "0100"; -- Negative (not A + 00000001) 
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test Logical AND (A AND B) 
        op <= "0101"; -- Logical AND (A AND B) 
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test Logical OR (A OR B) 
        op <= "0110"; -- Logical OR (A OR B) 
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test Logical XOR (A XOR B) 
        op <= "0111"; -- Logical XOR (A XOR B) 
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test Logical Shift Left (A << 1) 
        op <= "1000"; -- Logical Shift Left (A << 1) 
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test Logical Shift Right (A >> 1) 
        op <= "1001"; -- Logical Shift Right (A >> 1) 
 1η Γραπτή Εργασία Εργαστηρίου Ψηφιακών Συστημάτων (ΠΛΗ ΨΙΙ)  
 
13 
 
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test Pass Through (B) 
        op <= "1010";   
        carryin <= '0'; 
        wait for 10 ns; 
        -- Test default output (11111111) 
        op <= "1011";  
        wait for 10 ns; 
        op <= "1100";  
        wait for 10 ns; 
        -- Test Add (A + B) 
   InputA<="01110000"; 
   InputB<="01000000"; 
        op <= "0000"; -- Add (A + B) 
        carryin <= '0';   
   wait for 10 ns; 
        wait; 
    end process; 
end Behavioral; 