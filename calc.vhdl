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
    variable a, b, c : natural range 0 to 2**N-1;
  begin
    if rst = '1' then
      a := 1; b := 0; c := 0;
    elsif rising_edge(clk) then
      if en = '1' then
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
