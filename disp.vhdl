library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity disp is
  port (
    num : in std_logic_vector(19 downto 0);
    hex0 : out std_logic_vector(6 downto 0);
    hex1 : out std_logic_vector(6 downto 0);
    hex2 : out std_logic_vector(6 downto 0);
    hex3 : out std_logic_vector(6 downto 0);
    hex4 : out std_logic_vector(6 downto 0);
    hex5 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavior of disp is
  component dec2str
    port (
      num : in std_logic_vector(19 downto 0);
      dec0 : out std_logic_vector(3 downto 0);
      dec1 : out std_logic_vector(3 downto 0);
      dec2 : out std_logic_vector(3 downto 0);
      dec3 : out std_logic_vector(3 downto 0);
      dec4 : out std_logic_vector(3 downto 0);
      dec5 : out std_logic_vector(3 downto 0)
    );
  end component;

  component decoder
    port (
      num : in std_logic_vector(3 downto 0);
      hex : out std_logic_vector(6 downto 0)
    );
  end component;

  signal s_dec : std_logic_vector(23 downto 0);
  signal s_hex : std_logic_vector(41 downto 0);

begin
  dec2str0 : dec2str port map (
    num => num,
    dec0 => s_dec(3 downto 0), dec1 => s_dec(7 downto 4), dec2 => s_dec(11 downto 8), dec3 => s_dec(15 downto 12), dec4 => s_dec(19 downto 16), dec5 => s_dec(23 downto 20)
  );

  gen_decoder : for i in 0 to 5 generate
    decoder0 : decoder port map (
      num => s_dec(i*4+3 downto i*4),
      hex => s_hex(i*6+5 downto i*6)
    );
  end generate;

  hex0 <= s_hex(6 downto 0);
  hex1 <= s_hex(13 downto 7);
  hex2 <= s_hex(20 downto 14);
  hex3 <= s_hex(27 downto 21);
  hex4 <= s_hex(34 downto 28);
  hex5 <= s_hex(41 downto 35);
end architecture;
