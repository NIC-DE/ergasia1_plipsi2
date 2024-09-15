library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
 
entity DatapathWithRegisterFile is 
    Port ( 
         clk     : in STD_LOGIC;        -- Clock input 
        reset   : in STD_LOGIC;        -- Reset input 
        write   : in STD_LOGIC;        -- Write enable input 
        data_bus   : in STD_LOGIC_VECTOR(7 downto 0);  -- Data input (8-bit) 
          alu_op     : in STD_LOGIC_VECTOR(3 downto 0);  -- alu operation input 
(8-bit) 
          mem_or_reg : in STD_LOGIC; 
          carryIn    : in STD_LOGIC; 
          carryOut   : out STD_LOGIC; 
          alu_overflow   : out STD_LOGIC; 
          reg1add    : in STD_LOGIC_VECTOR(1 downto 0);  -- register 1 address 
input (2-bit) 
        reg2add    : in STD_LOGIC_VECTOR(1 downto 0);  -- register 2 address 
input (2-bit) 
          res_reg_add: in STD_LOGIC_VECTOR(1 downto 0);  -- register file 
address input (2-bit) 
        alu_out    : out STD_LOGIC_VECTOR(7 downto 0)  -- alu output (8-bit) 
    ); 
end DatapathWithRegisterFile; 
 
 
architecture Behavioral of DatapathWithRegisterFile is 
    signal alu_result : STD_LOGIC_VECTOR(7 downto 0); 
     signal rf_out1    : STD_LOGIC_VECTOR(7 downto 0); 
     signal rf_out2    : STD_LOGIC_VECTOR(7 downto 0); 
     signal mux_out    : STD_LOGIC_VECTOR(7 downto 0); 
  
      
component register_file is 
    Port ( 
        clk     : in STD_LOGIC;        -- Clock input 
        reset   : in STD_LOGIC;        -- Reset input 
        write   : in STD_LOGIC;        -- Write enable input 
        address : in STD_LOGIC_VECTOR(1 downto 0);  -- Address input (2-bit) 
        data_in : in STD_LOGIC_VECTOR(7 downto 0);  -- Data input (8-bit) 
          address_out1 : in STD_LOGIC_VECTOR(1 downto 0);  -- Address output1 
(2-bit) 
          address_out2 : in STD_LOGIC_VECTOR(1 downto 0);  -- Address output2 
(2-bit) 
        data_out1: out STD_LOGIC_VECTOR(7 downto 0); -- First output (8-bit) 
        data_out2: out STD_LOGIC_VECTOR(7 downto 0)  -- Second output (8-bit) 
    ); 
end component; 
 
component ALU is 
    Port ( 
        op       : in STD_LOGIC_VECTOR(3 downto 0);  -- Operation selection (4 
bits) 
        inputA   : in STD_LOGIC_VECTOR(7 downto 0);  -- Input A (8-bit) 
        inputB   : in STD_LOGIC_VECTOR(7 downto 0);  -- Input B (8-bit) 
        carryIn  : : in STD_LOGIC;                    -- Input carry 
        result   : out STD_LOGIC_VECTOR(7 downto 0); -- Result (8-bit) 
        carryOut : out STD_LOGIC;                    -- Output carry 
        overflow : out STD_LOGIC                     -- Overflow flag 
    ); 
  
 
18 
 
end component; 
 
component Multiplexer_2to1_8bit is 
    Port ( 
        Sel     : in STD_LOGIC;              -- Selection input 
        Data0   : in STD_LOGIC_VECTOR(7 downto 0); -- 8-bit data input 0 
        Data1   : in STD_LOGIC_VECTOR(7 downto 0); -- 8-bit data input 1 
        Output  : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output 
    ); 
end component; 
 
begin 
    -- Instantiate the Register File 
     RF: register_file port map ( 
            clk     => clk, 
            reset   => reset, 
            write   => write, 
            address => res_reg_add, -- Address selection (for example, select 
register 0) 
            data_in => alu_result, 
          address_out1 => reg1add, 
          address_out2 => reg2add, 
            data_out1 => rf_out1, 
            data_out2 => rf_out2 
        ); 
 
    -- Instantiate the ALU 
    ALUins: ALU port map ( 
            op       => alu_op, 
            inputA   => rf_out1, 
            inputB   => mux_out,  -- Connect data_in directly to ALU inputB 
            carryIn  => carryIn,     -- You can control this based on your 
design 
            result   => alu_result, 
            carryOut => carryOut, 
            overflow => alu_overflow 
        ); 
           
 
    mux: Multiplexer_2to1_8bit port map ( 
        Sel    => mem_or_reg, 
        Data0  => rf_out2, 
        Data1  => data_bus, 
        Output => mux_out 
    );         
 
 
    -- Output data from the Register File and ALU 
    alu_out <= alu_result; 
end Behavioral; 