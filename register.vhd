LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity latch IS
port ( A : in std_logic_vector(7 downto 0) ; -- 8-bit A input
res, clk : in std_logic ;
Q : out std_logic_vector(7 downto 0)) ; -- 8-bit output
end latch;
architecture behavior of latch is
begin
process (res, clk)
begin
if reset = ‘1’ then
	Q <= “00000000” ;
elsif (clk'EVENT AND clk = '1’) then
	Q <= A ;
end if ;
end process ;
end behavior ;