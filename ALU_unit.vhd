LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity ALU1 is -- ALU unit includes Reg. 3
port (
    clk, res : in std_logic ;
    R1, R2 : in unsigned(7 downto 0); -- 8-bit inputs A & B from Reg. 1 & Reg. 2
    opcode : in unsigned(7 downto 0); -- 8-bit opcode from Decoder
    
    Result_0_3 : out unsigned(3 downto 0); -- Lower 4 bits of the result
    Result_4_7 : out unsigned(3 downto 0)  -- Upper 4 bits of the result
);
end ALU1 ;

architecture calculation of ALU1 is
signal Reg1, Reg2, Result: unsigned(7 downto 0);

begin
Reg1 <= R1;
Reg2 <= R2;
process ( clk, res )
begin
    if res = '1' then
        Result <= "00000000";  -- Reset the result to 0
    elsif (clk'EVENT AND clk = '1') then
        case opcode is
            when "00000001" =>  -- Do addition for Reg1 and Reg2
                -- A + B = 87 + 9 = 96 (decimal), 0110 0000 (binary)
                Result <= Reg1 + Reg2;

            when "00000010" =>  -- Do subtraction for Reg1 and Reg2
                -- A - B = 87 - 9 = 78 (decimal), 0100 1110 (binary)
                Result <= Reg1 - Reg2;

            when "00000100" =>  -- Do inverse (NOT A)
                -- NOT A = 87 (decimal), 0101 0111 (binary) -> 1010 1000 (binary)
                Result <= not Reg1;

            when "00001000" =>  -- Do Boolean NAND
                -- A NAND B = 87 (decimal), 0101 0111 (binary) AND 9 (decimal), 0000 1001 (binary)
                -- A AND B = 0000 0001 (binary) -> NOT (0000 0001) = 1111 1110 (binary)
                Result <= not (Reg1 and Reg2);

            when "00010000" =>  -- Do Boolean NOR
                -- A NOR B = 87 (decimal), 0101 0111 (binary) OR 9 (decimal), 0000 1001 (binary)
                -- A OR B = 0101 1111 (binary) -> NOT (0101 1111) = 1010 0000 (binary)
                Result <= not (Reg1 or Reg2);

            when "00100000" =>  -- Do Boolean AND
                -- A AND B = 87 (decimal), 0101 0111 (binary) AND 9 (decimal), 0000 1001 (binary)
                -- A AND B = 0000 0001 (binary)
                Result <= Reg1 and Reg2;

            when "01000000" =>  -- Do Boolean XOR
                -- A XOR B = 87 (decimal), 0101 0111 (binary) XOR 9 (decimal), 0000 1001 (binary)
                -- A XOR B = 0101 1110 (binary)
                Result <= Reg1 xor Reg2;

            when "10000000" =>  -- Do Boolean OR
                -- A OR B = 87 (decimal), 0101 0111 (binary) OR 9 (decimal), 0000 1001 (binary)
                -- A OR B = 0101 1111 (binary)
                Result <= Reg1 or Reg2;

            when others =>  -- Don’t care, do nothing
                --Result <= Result;
        end case ;
    end if;
end process ;

-- Split the 8-bit result into two 4-bit outputs
Result_0_3 <= Result(3 downto 0);  -- Lower 4 bits of Result
Result_4_7 <= Result(7 downto 4);  -- Upper 4 bits of Result

end calculation ;