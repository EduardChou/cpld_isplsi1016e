LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY cpld_isplsi1016e IS
    PORT (
        clk, FR, switch : IN STD_LOGIC;
        HA, HB, HC : IN STD_LOGIC;
        T1, T2, T3, T4, T5, T6 : OUT STD_LOGIC);
END;
ARCHITECTURE cpld_isplsi1016e_architecture OF cpld_isplsi1016e IS
    SIGNAL pwm_sig : STD_LOGIC := '1';
BEGIN
    PROCESS (clk, FR, switch, HA, HB, HC)
        VARIABLE count : STD_LOGIC_VECTOR(10 DOWNTO 0) := "00000000000";
    BEGIN
        IF (clk'event) AND (clk = '1') THEN
            count := count + 1;
            IF (count <= 360) AND (switch = '0') THEN
                pwm_sig <= '1';
            ELSIF (count <= 960) AND (switch = '1') THEN
                pwm_sig <= '1';
            ELSIF count < 1200 THEN
                pwm_sig <= '0';
            ELSE
                count := "00000000000";
            END IF;
        END IF;
        T1 <= NOT (pwm_sig AND ((FR AND HA AND (NOT HB)) OR ((NOT FR) AND (NOT HA) AND HB)));
        T2 <= NOT (pwm_sig AND ((FR AND HA AND (NOT HC)) OR ((NOT FR) AND (NOT HA) AND HC)));
        T3 <= NOT (pwm_sig AND ((FR AND HB AND (NOT HC)) OR ((NOT FR) AND (NOT HB) AND HC)));
        T4 <= NOT (pwm_sig AND ((FR AND HB AND (NOT HA)) OR ((NOT FR) AND (NOT HB) AND HA)));
        T5 <= NOT (pwm_sig AND ((FR AND HC AND (NOT HA)) OR ((NOT FR) AND (NOT HC) AND HA)));
        T6 <= NOT (pwm_sig AND ((FR AND HC AND (NOT HB)) OR ((NOT FR) AND (NOT HC) AND HB)));
    END PROCESS;
END cpld_isplsi1016e_architecture;