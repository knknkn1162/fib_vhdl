library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fib_tb is
end entity;


architecture testbench of fib_tb is
  component fib
    generic(N : natural);
    port (
      clk, rst : in std_logic;
      hex0 : out std_logic_vector(6 downto 0);
      hex1 : out std_logic_vector(6 downto 0);
      hex2 : out std_logic_vector(6 downto 0);
      hex3 : out std_logic_vector(6 downto 0);
      hex4 : out std_logic_vector(6 downto 0);
      hex5 : out std_logic_vector(6 downto 0)
      
    );
  end component;

  signal N : natural := 5; -- 10 MHz
  signal clk, rst : std_logic;
  signal hex0, hex1, hex2, hex3, hex4, hex5 : std_logic_vector(6 downto 0);
  constant clk_period : time := 20 ns;
  signal stop : boolean;

begin
  uut : fib generic map (N=>N)
  port map (
    clk => clk, rst => rst,
    hex0 => hex0, hex1 => hex1, hex2 => hex2, hex3 => hex3, hex4 => hex4, hex5 => hex5
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
    wait for clk_period*3;
    rst <= '1'; wait for 1 ns; rst <= '0';
    assert hex0 = "1111001"; assert hex1 = "1000000"; -- 1
    wait for clk_period*4; wait until rising_edge(clk); wait for 1 ns;
    assert hex0 = "1111001"; assert hex1 = "1000000"; -- 1
    wait for clk_period*4; wait until rising_edge(clk); wait for 1 ns;
    assert hex0 = "0100100"; assert hex1 = "1000000"; -- 2
    wait for clk_period*4; wait until rising_edge(clk); wait for 1 ns;
    assert hex0 = "0110000"; assert hex1 = "1000000"; -- 3
    wait for clk_period*4; wait until rising_edge(clk); wait for 1 ns;
    assert hex0 = "0010010"; assert hex1 = "1000000"; -- 5
    wait for clk_period*4; wait until rising_edge(clk); wait for 1 ns;
    assert hex0 = "0000000"; assert hex1 = "1000000"; -- 8
    wait for clk_period*4; wait until rising_edge(clk); wait for 1 ns;
    assert hex0 = "0100001"; assert hex1 = "1000000"; -- 13
    wait for clk_period*4; wait until rising_edge(clk); wait for 1 ns;
    assert hex0 = "0010010"; assert hex1 = "1111001"; -- 21


    
    -- skip
    stop <= TRUE;
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;
end architecture;
