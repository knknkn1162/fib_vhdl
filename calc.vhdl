library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity calc is
  generic(N: natural);
  port (
    clk, rst : in std_logic;
    en : in std_logic;
    z : out std_logic_vector(N-1 downto 0)
  );
end entity;

architecture behavior of calc is
begin
  process(clk, rst)
    -- NOTE: https://www.intel.com/content/www/us/en/programmable/support/support-resources/knowledge-base/solutions/rd01072011_91.html
    variable a : natural range 0 to 2**N-1 := 1;
    variable b, c : natural range 0 to 2**N-1 := 0;
  begin
    if rising_edge(clk) then
      if rst = '1' then
        a := 1; b := 0; c := 0;
      elsif en = '1' then
        if a+b < 2**N-1 then
          c := b;
          b := a;
          a := c + b;
        else
          a := 0;
          b := 0;
          c := 0;
        end if;
      end if;
    end if;
    z <= std_logic_vector(to_unsigned(a, N));
  end process;
end architecture;
