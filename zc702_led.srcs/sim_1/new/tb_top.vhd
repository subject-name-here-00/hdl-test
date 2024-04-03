library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is
	generic (
		G_CNT_WIDTH : integer := 4;
		G_PERIOD    : integer := 10;
		dt : time := 1.0 ns
	);
end tb_top;

architecture tb of tb_top is

	signal sys_clk_p : std_logic := '1';
	signal sys_clk_n : std_logic := '0';
	signal o_led_n   : std_logic := '1';

begin

	sys_clk_p <= not sys_clk_p after dt/2.0;
	sys_clk_n <= not sys_clk_p;

	u_uut :entity work.top
		generic map (
			G_CNT_WIDTH => G_CNT_WIDTH,
			G_PERIOD    => G_PERIOD
		)
		port map (
			sys_clk_p => sys_clk_p,
			sys_clk_n => sys_clk_n,
			o_led_n   => o_led_n
		);

end tb;
