library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enable_generator_tb is
end entity;

architecture behavior of enable_generator_tb is
  component enable_generator is
    generic(N : natural);
    port (
      clk, rst : in std_logic;
      ena : out std_logic
    );
  end component;

  constant N : natural := 5;
  signal clk, rst, ena : std_logic;
  constant clk_period : time := 10 ns;
  signal stop : boolean;

begin
  uut : enable_generator generic map(N=>N) port map (
    clk => clk, rst => rst, ena => ena
  );

  clk_process: process
  begin
    while not stop loop
      clk <= '0'; wait for clk_period/2;
      clk <= '1'; wait for clk_period/2;
    end loop;
    wait;
  end process;

  stim_proc : process
  begin
    wait for clk_period;
    rst <= '1'; wait for 1 ns; rst <= '0';
    assert ena = '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert ena = '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert ena = '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert ena = '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert ena = '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert ena = '1';
    -- skip
    stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
