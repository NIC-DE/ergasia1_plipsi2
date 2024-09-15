use IEEE.STD_LOGIC_1164.ALL; 
 
entity DatapathWithRegisterFile_TB is 
end DatapathWithRegisterFile_TB; 
 
architecture Behavioral of DatapathWithRegisterFile_TB is 
    -- Component declaration 
    component DatapathWithRegisterFile is 
        Port ( 
        clk     : in STD_LOGIC;        -- Clock input 
        reset   : in STD_LOGIC;        -- Reset input 
        write   : in STD_LOGIC;        -- Write enable input 
        data_bus   : in STD_LOGIC_VECTOR(7 downto 0);  -- Data input (8
bit) 
        alu_op     : in STD_LOGIC_VECTOR(3 downto 0);  -- alu operation 
input (8-bit) 
        mem_or_reg : in STD_LOGIC; 
        carryIn    : in STD_LOGIC; 
        carryOut   : out STD_LOGIC; 
        alu_overflow   : out STD_LOGIC; 
        reg1add    : in STD_LOGIC_VECTOR(1 downto 0);  -- register 1 
address input (2-bit) 
        reg2add    : in STD_LOGIC_VECTOR(1 downto 0);  -- register 2 
address input (2-bit) 
        res_reg_add: in STD_LOGIC_VECTOR(1 downto 0);  -- register file 
address input (2-bit) 
        alu_out    : out STD_LOGIC_VECTOR(7 downto 0)  -- alu output (8
bit) 
        ); 
    end component; 
  
    -- Signal declaration 
    signal clk: STD_LOGIC; 
 signal reset: STD_LOGIC; 
 signal write: STD_LOGIC; 
 signal data_bus: STD_LOGIC_VECTOR(7 downto 0); 
 signal alu_op: STD_LOGIC_VECTOR(3 downto 0); 
 signal mem_or_reg: STD_LOGIC; 
 signal carryIn: STD_LOGIC; 
 signal carryOut: STD_LOGIC; 
 signal alu_overflow: STD_LOGIC; 
 signal reg1add: STD_LOGIC_VECTOR(1 downto 0); 
 signal reg2add: STD_LOGIC_VECTOR(1 downto 0); 
 1η Γραπτή Εργασία Εργαστηρίου Ψηφιακών Συστημάτων (ΠΛΗ ΨΙΙ)  
 
20 
 
 signal res_reg_add: STD_LOGIC_VECTOR(1 downto 0); 
 signal alu_out: STD_LOGIC_VECTOR(7 downto 0); 
  
begin 
    -- Instantiate the component 
    uut: DatapathWithRegisterFile port map ( 
        clk => clk, 
  reset => reset, 
  write => write, 
  data_bus => data_bus, 
  alu_op => alu_op, 
  mem_or_reg => mem_or_reg, 
  carryIn => carryIn, 
  carryOut => carryOut, 
  alu_overflow => alu_overflow, 
  reg1add => reg1add, 
  reg2add => reg2add, 
  res_reg_add => res_reg_add, 
  alu_out => alu_out 
    ); 
  
 -- Clock process 
    process 
    begin 
        while now < 360 ps loop 
            clk <= '0'; 
            wait for 20 ps; 
            clk <= '1'; 
            wait for 20 ps; 
        end loop; 
        wait; 
    end process; 
  
     -- Stimulus process 
    process 
    begin 
  --reset first and write mode is permanently enabled (for now) 
  reset <= '1'; 
  write <= '1'; 
  carryIn <= '0'; 
  wait for 10 ps; 
  reset <= '0'; 
  -- op1... LDI R1,#20 
        alu_op <= "1010"; -- Passthrough B 
  data_bus <= "00010100"; 
  mem_or_reg <= '1'; 
  reg1add <= "00"; 
  reg2add <= "00"; 
  res_reg_add <= "01"; 
        wait for 30 ps; 
  -- op2... LDI R2,#52 
        alu_op <= "1010"; -- Passthrough B 
  data_bus <= "00110100"; 
  mem_or_reg <= '1'; 
  reg1add <= "00"; 
  reg2add <= "00"; 
  res_reg_add <= "10"; 
        wait for 40 ps; 
  -- op3... ADD R0,R1,R2 
        alu_op <= "0000"; -- ADD without carry 
  mem_or_reg <= '0'; 
  reg1add <= "01"; 
  reg2add <= "10"; 
1η Γραπτή Εργασία Εργαστηρίου Ψηφιακών Συστημάτων (ΠΛΗ ΨΙΙ)  
res_reg_add <= "00"; 
wait for 40 ps; -- op4... MOV R3,R0 
alu_op <= "1010"; -- Passthrough B 
mem_or_reg <= '0'; 
reg1add <= "00"; 
reg2add <= "00"; 
res_reg_add <= "11"; 
wait for 40 ps; -- op5... AND R3,R3,#240 
alu_op <= "0101"; -- LOGICAL AND 
data_bus <= "11110000"; -- 240 decimal 
mem_or_reg <= '1'; 
reg1add <= "11"; 
reg2add <= "00"; 
res_reg_add <= "11"; 
wait for 40 ps; -- op6... out R0 
alu_op <= "1010"; -- Passthrough B 
mem_or_reg <= '0'; 
reg2add <= "00"; 
res_reg_add <= "00"; 
wait for 40 ps; -- op7... out R1 
alu_op <= "1010"; -- Passthrough B 
mem_or_reg <= '0'; 
reg2add <= "01"; 
res_reg_add <= "01"; 
wait for 40 ps; -- op8... out R2 
alu_op <= "1010"; -- Passthrough B 
mem_or_reg <= '0'; 
reg2add <= "10"; 
res_reg_add <= "10"; 
wait for 40 ps; -- op9... out R3 
alu_op <= "1010"; -- Passthrough B 
mem_or_reg <= '0'; 
reg2add <= "11"; 
res_reg_add <= "11"; 
wait; 
end process; 
end Behavioral;