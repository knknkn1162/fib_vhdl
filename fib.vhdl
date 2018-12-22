library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fib is
  generic(N : natural := 50000000);
  port (
    clk, rst : in std_logic;
    hex0 : out std_logic_vector(6 downto 0);
    hex1 : out std_logic_vector(6 downto 0);
    hex2 : out std_logic_vector(6 downto 0);
    hex3 : out std_logic_vector(6 downto 0);
    hex4 : out std_logic_vector(6 downto 0);
    hex5 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavior of fib is
  component calc
    generic(N: natural);
    port (
      clk, rst : in std_logic;
      en : in std_logic;
      z : out std_logic_vector(N-1 downto 0)
    );
  end component;

  component enable_generator
    generic(N : natural);
    port (
      clk, rst : in std_logic;
      ena : out std_logic
    );
  end component;

  component disp
    port (
      num : in std_logic_vector(19 downto 0);
      hex0 : out std_logic_vector(6 downto 0);
      hex1 : out std_logic_vector(6 downto 0);
      hex2 : out std_logic_vector(6 downto 0);
      hex3 : out std_logic_vector(6 downto 0);
      hex4 : out std_logic_vector(6 downto 0);
      hex5 : out std_logic_vector(6 downto 0)
    );
  end component;

  constant SIZE : natural := 20;
  signal en : std_logic;
  signal num : std_logic_vector(SIZE-1 downto 0);

begin
  enable_generator0 : enable_generator generic map (N=>N)
  port map (
    clk => clk, rst => rst,
    ena => en
  );

  calc0 : calc generic map (N=>SIZE)
  port map (
    clk => clk, rst => rst,
    en => en, z => num
  );

  disp0 : disp port map (
    num => num,
    hex0 => hex0, hex1 => hex1, hex2 => hex2, hex3 => hex3, hex4 => hex4, hex5 => hex5
  );
end architecture;
