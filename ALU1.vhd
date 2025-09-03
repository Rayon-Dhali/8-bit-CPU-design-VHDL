library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU1 is
    port ( 
        Clk     : in std_logic;                      -- Clock signal
        A, B    : in unsigned (7 downto 0);         -- 8-bit input operands
        OP      : in unsigned (15 downto 0);        -- 16-bit opcode
        Neg1, Neg2    : out std_logic;              -- Negative flag for A and B
        Result  : out unsigned (7 downto 0);        -- 8-bit result output
        R1      : out unsigned (3 downto 0);        -- Lower 4 bits of result
        R2      : out unsigned (3 downto 0)         -- Upper 4 bits of result
    );
end ALU1;

architecture calculation of ALU1 is
    signal Reg1, Reg2, ALU_Result: unsigned (7 downto 0);  -- Internal signals for operands and result
    signal Neg_Flag: std_logic;                           -- Signal to track negative results
begin
    -- Assign inputs to internal registers
    Reg1 <= A;
    Reg2 <= B;

    process (Clk, OP)
    begin
        if rising_edge(Clk) then
            case OP is
                -- OP = "0000000000000001" -> Addition (A + B)
                when "0000000000000001" =>
                    ALU_Result <= Reg1 + Reg2;
                    Neg_Flag <= '0'; -- Addition is unsigned, no negative result.

                -- OP = "0000000000000010" -> Subtraction (A - B)
                when "0000000000000010" =>
                    if Reg1 >= Reg2 then
                        ALU_Result <= Reg1 - Reg2;
                        Neg_Flag <= '0'; -- No negative result
                    else
                        ALU_Result <= Reg2 - Reg1; -- Use absolute difference
                        Neg_Flag <= '1'; -- Indicate a negative result
                    end if;

                -- OP = "0000000000000100" -> NOT (A)
                when "0000000000000100" =>
                    ALU_Result <= not Reg1;
                    Neg_Flag <= '0'; -- Neg flag not applicable here

                -- OP = "0000000000001000" -> NAND (A NAND B)
                when "0000000000001000" =>
                    ALU_Result <= not (Reg1 and Reg2); -- Perform NAND operation
                    Neg_Flag <= '0';

                -- OP = "0000000000010000" -> NOR (A NOR B)
                when "0000000000010000" =>
                    ALU_Result <= not (Reg1 or Reg2); -- Perform NOR operation
                    Neg_Flag <= '0';

                -- OP = "0000000000100000" -> AND (A AND B)
                when "0000000000100000" =>
                    ALU_Result <= Reg1 and Reg2; -- Perform AND operation
                    Neg_Flag <= '0';

                -- OP = "0000000001000000" -> XOR (A XOR B)
                when "0000000001000000" =>
                    ALU_Result <= Reg1 xor Reg2; -- Perform XOR operation
                    Neg_Flag <= '0';

                -- OP = "0000000010000000" -> OR (A OR B)
                when "0000000010000000" =>
                    ALU_Result <= Reg1 or Reg2; -- Perform OR operation
                    Neg_Flag <= '0';

                -- Default case: Maintain the current result
                when others =>
                    ALU_Result <= (others => '0'); -- Reset result to 0
                    Neg_Flag <= '0'; -- Reset negative flag
            end case;
        end if;
    end process;

    -- Split the result into two 4-bit outputs
    R1 <= ALU_Result(3 downto 0);     -- Lower 4 bits of result
    R2 <= ALU_Result(7 downto 4);     -- Upper 4 bits of result

    -- Assign the negative flags for inputs A and B
    Neg1 <= A(7); -- MSB of A indicates if A is negative
    Neg2 <= B(7); -- MSB of B indicates if B is negative
end calculation;
