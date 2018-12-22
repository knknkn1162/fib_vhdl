library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity num2str10_tb is
end entity;

architecture testbench of num2str10_tb is
  component num2str10
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
  uut : num2str10 port map (
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
    assert dec2 = "0000";
    assert dec3 = "0000";
    assert dec4 = "0000";
    assert dec5 = "0000";
    -- success message
    assert false report "end of test" severity note;
    wait;
  end process;

end architecture;
