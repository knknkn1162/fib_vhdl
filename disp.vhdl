library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity disp is
  port (
    num : in std_logic_vector(23 downto 0);
    hex0 : out std_logic_vector(6 downto 0);
    hex1 : out std_logic_vector(6 downto 0);
    hex2 : out std_logic_vector(6 downto 0);
    hex3 : out std_logic_vector(6 downto 0);
    hex4 : out std_logic_vector(6 downto 0);
    hex5 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavior of disp is
  component decoder
    port (
      num : in std_logic_vector(3 downto 0);
      hex : out std_logic_vector(6 downto 0)
    );
  end component;

  signal s_hex : std_logic_vector(41 downto 0);
begin
  gen_decoder : for i in 0 to 5 generate
    decoder0 : decoder port map (
      num => num(i*4+3 downto i*4),
      hex => s_hex(i*7+6 downto i*7)
    );
  end generate;

  hex0 <= s_hex(6 downto 0);
  hex1 <= s_hex(13 downto 7);
  hex2 <= s_hex(20 downto 14);
  hex3 <= s_hex(27 downto 21);
  hex4 <= s_hex(34 downto 28);
  hex5 <= s_hex(41 downto 35);
end architecture;
