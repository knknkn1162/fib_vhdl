library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity calc_tb is
end entity;

architecture testbench of calc_tb is
  component calc
    generic(N: natural);
    port (
      clk, rst : in std_logic;
      en : in std_logic;
      z : out std_logic_vector(N-1 downto 0)
    );
  end component;

  constant N : natural := 20;
  signal clk, rst, en : std_logic;
  signal z : std_logic_vector(N-1 downto 0);
  constant clk_period : time := 10 ns;
  signal stop : boolean;

begin
  uut : calc generic map(N=>N) port map (
    clk => clk, rst => rst, en => en,
    z => z
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
    en <= '1';
    assert z = X"0000" & "0001";
    wait until rising_edge(clk); wait for 1 ns;
    assert z = X"0000" & "0001";
    wait until rising_edge(clk); wait for 1 ns;
    assert z = X"0000" & "0010";
    wait until rising_edge(clk); wait for 1 ns;
    assert z = X"0000" & "0011";
    wait until rising_edge(clk); wait for 1 ns;
    assert z = X"0000" & "0101";
    en <= '0';
    wait until rising_edge(clk); wait for 1 ns;
    assert z = X"0000" & "0101";
    en <= '1';
    wait until rising_edge(clk); wait for 1 ns;
    assert z = X"0000" & "1000";

    stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process; 
end architecture;
