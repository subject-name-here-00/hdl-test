library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	generic (
		G_CNT_WIDTH : integer := 32;
		G_PERIOD    : integer := 200_000_000
	);
	port (
		sys_clk_p : in  std_logic;
		sys_clk_n : in  std_logic;
		o_led_n   : out std_logic := '1'
	);
end top;

architecture top of top is

	component clk_wiz_0
		port (
			clk_out1  : out std_logic;
			clk_in1_p : in  std_logic;
			clk_in1_n : in  std_logic
		);
	end component clk_wiz_0;

	signal m_clk : std_logic := '0';

	signal q_cnt : unsigned(G_CNT_WIDTH-1 downto 0) := (others => '0');

	attribute MARK_DEBUG : string;
	attribute MARK_DEBUG of q_cnt   : signal is "TRUE";
	attribute MARK_DEBUG of o_led_n : signal is "TRUE";

begin

	u_clk : clk_wiz_0
		port map (
			clk_in1_p => sys_clk_p,
			clk_in1_n => sys_clk_n,
			clk_out1  => m_clk
		);

	seq_proc : process(m_clk) begin
		if rising_edge(m_clk) then
			if q_cnt = 0 then
				q_cnt <= to_unsigned(G_PERIOD - 1, q_cnt'length);
				o_led_n <= not o_led_n;
			else
				q_cnt <= q_cnt - 1;
			end if;
			
--			if q_cnt = 0 then
--				o_led_n <= not o_led_n;
--			end if;
		end if;
	end process seq_proc;

end top;
