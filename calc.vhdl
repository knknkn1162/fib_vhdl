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
  component flopr_en
    generic(N : natural);
    port (
      clk, rst, en: in std_logic;
      load : in std_logic_vector(N-1 downto 0);
      a : in std_logic_vector(N-1 downto 0);
      y : out std_logic_vector(N-1 downto 0)
    );
  end component;

  signal a, b : std_logic_vector(N-1 downto 0);
  signal an, bn, cn : std_logic_vector(N-1 downto 0);
  signal as, ys : std_logic_vector(3*N-1 downto 0);
  constant CONST_ONE : std_logic_vector(N-1 downto 0) := (0 => '1', others => '0');
  constant CONST_ZERO : std_logic_vector(N-1 downto 0) := (others => '0');
  constant CONST_LOAD : std_logic_vector(3*N-1 downto 0) := CONST_ONE & CONST_ZERO & CONST_ZERO;
begin
  flopr_en0 : flopr_en generic map(N=>3*N)
  port map (
    clk => clk, rst => rst, en => en,
    load => CONST_LOAD,
    a => as,
    y => ys
  );

  a <= ys(3*N-1 downto 2*N); b <= ys(2*N-1 downto N); c <= ys(N-1 downto 0);
  z <= a;

  an <= std_logic_vector(unsigned(a) + unsigned(b)); bn <= a; cn <= b;
  as <= an & bn & cn;
end architecture;
