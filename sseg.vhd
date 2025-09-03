LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg IS
    PORT (
        bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);  -- 4-bit signed BCD input
        sign : IN STD_LOGIC;                    -- Sign input (1 for negative, 0 for positive)
        leds_right : OUT STD_LOGIC_VECTOR(1 TO 7); -- 7-segment for magnitude (right display)
        leds_left : OUT STD_LOGIC_VECTOR(1 TO 7)   -- 7-segment for sign (left display)
    );
END sseg;

ARCHITECTURE Behavior OF sseg IS
BEGIN
    -- Magnitude display (right 7-segment display)
    PROCESS (bcd)
    BEGIN
        CASE bcd IS
            WHEN "0000" => leds_right <= NOT "1111110"; -- 0
            WHEN "0001" => leds_right <= NOT "0110000"; -- 1
            WHEN "0010" => leds_right <= NOT "1101101"; -- 2
            WHEN "0011" => leds_right <= NOT "1111001"; -- 3
            WHEN "0100" => leds_right <= NOT "0110011"; -- 4
            WHEN "0101" => leds_right <= NOT "1011011"; -- 5
            WHEN "0110" => leds_right <= NOT "1011111"; -- 6
            WHEN "0111" => leds_right <= NOT "1110000"; -- 7
            WHEN "1000" => leds_right <= NOT "1111111"; -- 8
            WHEN "1001" => leds_right <= NOT "1110011"; -- 9
				
				WHEN "1010" => leds_right <= NOT "1110111"; -- A
				WHEN "1011" => leds_right <= NOT "0011111"; -- B
				WHEN "1100" => leds_right <= NOT "1001110"; -- C
				WHEN "1101" => leds_right <= NOT "0111101"; -- D
				WHEN "1110" => leds_right <= NOT "1001111"; -- E
				WHEN "1111" => leds_right <= NOT "1000111"; -- F
				
				
            WHEN OTHERS => leds_right <= "-------"; -- Blank for invalid BCD
        END CASE;
    END PROCESS;

    -- Sign display (left 7-segment display)
    PROCESS (sign)
    BEGIN
        IF sign = '1' THEN
            -- Negative sign ('-' is represented by turning on the middle segment)
            leds_left <= "0000001";  -- Only middle segment on
        ELSE
            -- Positive (no sign), all segments off
            leds_left <= "0000000";  -- All segments off
        END IF;
    END PROCESS;

END Behavior;