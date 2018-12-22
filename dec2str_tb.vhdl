library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dec2str_tb is
end entity;

architecture testbench of dec2str_tb is
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

  signal num : std_logic_vector(19 downto 0);
  signal dec0, dec1, dec2, dec3, dec4, dec5 : std_logic_vector(3 downto 0);
  signal PERIOD : time := 20 ns;
  
begin
  uut : dec2str port map (
    num => num,
    dec0 => dec0, dec1 => dec1, dec2 => dec2, dec3 => dec3, dec4 => dec4, dec5 => dec5
  );

  stim_proc : process
  begin
    wait for PERIOD;
    num <= std_logic_vector(to_unsigned(19, 20));
    wait for PERIOD/2;
    assert dec0 = "1001";
    assert dec1 = "0001";
    assert dec2 = "XXXX";
    assert dec3 = "XXXX";
    assert dec4 = "XXXX";
    assert dec5 = "XXXX";
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;

end architecture;
