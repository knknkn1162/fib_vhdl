library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enable_generator is
  generic(N : natural);
  port (
    clk, rst : in std_logic;
    ena : out std_logic
  );
end entity;

architecture behavior of enable_generator is
  signal cnt : natural range 0 to N;
begin
  process(clk, rst)
  begin
    if rst = '1' then
      cnt <= 0;
    elsif rising_edge(clk) then
      if cnt = N then
        cnt <= 0;
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;
  ena <= '1' when cnt = N else '0';
end architecture;
