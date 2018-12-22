library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity decoder is
  port (
    num : in std_logic_vector(3 downto 0);
    hex : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavior of decoder is
begin
  process(num)
  begin
    case (num) is
      when "0000" => hex <= "1000000";
      when "0001" => hex <= "1111001";
      when "0010" => hex <= "0100100";
      when "0011" => hex <= "0110000";
      when "0100" => hex <= "0011001";
      when "0101" => hex <= "0010010";
      when "0110" => hex <= "0000010";
      when "0111" => hex <= "1011000";
      when "1000" => hex <= "0000000";
      when "1001" => hex <= "0010000";
      when "1010" => hex <= "0001000";
      when "1011" => hex <= "0000011";
      when "1100" => hex <= "1000110";
      when "1101" => hex <= "0100001";
      when "1110" => hex <= "0000110";
      when "1111" => hex <= "0001110";
      when others => hex <= "1111111";
    end case;
  end process;
end architecture;
