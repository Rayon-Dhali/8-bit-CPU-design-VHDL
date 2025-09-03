LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY machine IS
PORT( 
    data_in, clk, reset : IN std_logic; -- Reset is active-low now
    student_id          : OUT std_logic_vector(3 DOWNTO 0);
    current_state       : OUT std_logic_vector(3 DOWNTO 0)
);
END machine;

ARCHITECTURE fsm OF machine IS
    -- Define state types for the FSM
    TYPE state_type IS (s0, s1, s2, s3, s4, s5, s6, s7); -- States in sequential order
    SIGNAL yfsm: state_type; -- Current state signal
BEGIN
    -- State transition process
    PROCESS (clk, reset)
    BEGIN
        -- Reset logic (active-low)
        IF reset = '0' THEN
            yfsm <= s0; -- Default to state s0 on reset
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE yfsm IS
                WHEN s0 =>
                    IF data_in = '1' THEN
                        yfsm <= s1;
                    END IF;

                WHEN s1 =>
                    IF data_in = '1' THEN
                        yfsm <= s2;
                    END IF;

                WHEN s2 =>
                    IF data_in = '1' THEN
                        yfsm <= s3;
                    END IF;

                WHEN s3 =>
                    IF data_in = '1' THEN
                        yfsm <= s4;
                    END IF;

                WHEN s4 =>
                    IF data_in = '1' THEN
                        yfsm <= s5;
                    END IF;

                WHEN s5 =>
                    IF data_in = '1' THEN
                        yfsm <= s6;
                    END IF;

                WHEN s6 =>
                    IF data_in = '1' THEN
                        yfsm <= s7;
                    END IF;

                WHEN s7 =>
                    IF data_in = '1' THEN
                        yfsm <= s0; -- Loop back to s0
                    END IF;

                WHEN OTHERS =>
                    yfsm <= s0; -- Default to s0 (safety case)
            END CASE;
        END IF;
    END PROCESS;

    -- Output process for student_id and current_state
    PROCESS (yfsm)
    BEGIN
    CASE yfsm IS
        WHEN s0 => current_state <= "0000"; student_id <= "0000"; -- d2 = 0
        WHEN s1 => current_state <= "0001"; student_id <= "0001"; -- d3 = 1
        WHEN s2 => current_state <= "0010"; student_id <= "0010"; -- d4 = 2
        WHEN s3 => current_state <= "0011"; student_id <= "0011"; -- d5 = 3
        WHEN s4 => current_state <= "0100"; student_id <= "1000"; -- d6 = 8
        WHEN s5 => current_state <= "0101"; student_id <= "0111"; -- d7 = 7
        WHEN s6 => current_state <= "0110"; student_id <= "0000"; -- d8 = 0
        WHEN s7 => current_state <= "0111"; student_id <= "1001"; -- d9 = 9
    END CASE;
END PROCESS;
END fsm;