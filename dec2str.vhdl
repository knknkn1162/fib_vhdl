library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dec2str is
  port (
    num : in std_logic_vector(19 downto 0);
    dec0 : out std_logic_vector(3 downto 0);
    dec1 : out std_logic_vector(3 downto 0);
    dec2 : out std_logic_vector(3 downto 0);
    dec3 : out std_logic_vector(3 downto 0);
    dec4 : out std_logic_vector(3 downto 0);
    dec5 : out std_logic_vector(3 downto 0)
  );
end entity;

architecture behavior of dec2str is
  signal dec : std_logic_vector(23 downto 0);
begin
  process(num)
    variable n : natural range 0 to 999999;
  begin
    if not is_X(num) then
      n := to_integer(unsigned(num));
      for i in 0 to 5 loop
        if n = 0 then
          dec(i*4+3 downto i*4) <= (others => 'X');
        else
          dec(i*4+3 downto i*4) <= std_logic_vector(to_unsigned(n-(n/10)*10, 4));
          n := n/10;
        end if;
      end loop;
    end if;
  end process;
  dec0 <= dec(3 downto 0);
  dec1 <= dec(7 downto 4);
  dec2 <= dec(11 downto 8);
  dec3 <= dec(15 downto 12);
  dec4 <= dec(19 downto 16);
  dec5 <= dec(23 downto 20);
end architecture;
