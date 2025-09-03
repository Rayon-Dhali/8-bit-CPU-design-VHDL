LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY dec1 IS

PORT ( w   : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
       En  : IN STD_LOGIC ;
       y: OUT STD_LOGIC_VECTOR(15 DOWNTO 0) ) ;
END dec1;

ARCHITECTURE Behavior OF dec1 IS
   SIGNAL Enw : STD_LOGIC_VECTOR(4 DOWNTO 0) ;
BEGIN
   Enw <= En & w ;
   WITH Enw SELECT
        y <= "0000000000000001" WHEN "10000", -- w = 0000, En = 1
             "0000000000000010" WHEN "10001", -- w = 0001, En = 1
             "0000000000000100" WHEN "10010", -- w = 0010, En = 1
             "0000000000001000" WHEN "10011", -- w = 0011, En = 1
             "0000000000010000" WHEN "10100", -- w = 0100, En = 1
             "0000000000100000" WHEN "10101", -- w = 0101, En = 1
             "0000000001000000" WHEN "10110", -- w = 0110, En = 1
             "0000000010000000" WHEN "10111", -- w = 0111, En = 1
             "0000000100000000" WHEN "11000", -- w = 1000, En = 1
             "0000001000000000" WHEN "11001", -- w = 1001, En = 1
             "0000010000000000" WHEN "11010", -- w = 1010, En = 1
             "0000100000000000" WHEN "11011", -- w = 1011, En = 1
             "0001000000000000" WHEN "11100", -- w = 1100, En = 1
             "0010000000000000" WHEN "11101", -- w = 1101, En = 1
             "0100000000000000" WHEN "11110", -- w = 1110, En = 1
             "1000000000000000" WHEN "11111", -- w = 1111, En = 1
             "0000000000000000" WHEN OTHERS;  -- Default case (Don't care)
END Behavior;