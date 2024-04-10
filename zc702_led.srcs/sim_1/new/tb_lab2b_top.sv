`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Maxim Kuleshov
// 
// Create Date: 04/10/2024 08:53:35 PM
// Module Name: lab2b_top_tb
// Target Devices: zc702
// Description: use both MUX and LED blinker from previous labs
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_lab2b_top ();

// UUT generics
	localparam      G_CLK_FREQUENCY = 1e9; // Hz
	localparam real G_BLINK_PERIOD [0:3] = '{1e-6, 2e-6, 3e-6, 4e-6}; // s
	localparam int  G_CNT_NUM       = $size(G_BLINK_PERIOD); // number of independent counters
	localparam int  G_SEL_WIDTH     = $ceil($clog2(G_CNT_NUM)); // selector bit width
	localparam int  G_LED_WIDTH     = 8; // bit width of LED "bus"

// TB constants
	localparam      T_CLK = 1e9 / G_CLK_FREQUENCY; // ns

// UUT i/o signals
	logic                   i_clk = '0;
	logic [G_SEL_WIDTH-1:0] i_sel = '0; // MUX selector
	logic [G_LED_WIDTH-1:0] o_led = '0;

	always #(T_CLK/2) i_clk = ~i_clk; // simulate clock

	always #1e4 i_sel = i_sel + 1; // simulate selector

	lab2b_top #(
		.G_CLK_FREQUENCY (G_CLK_FREQUENCY), // Hz
		.G_LED_WIDTH     (G_LED_WIDTH    ), // bit width of LED "bus"
		.G_CNT_NUM       (G_CNT_NUM      ), // number of independent counters
		.G_SEL_WIDTH     (G_SEL_WIDTH    ), // selector bit width
		.G_BLINK_PERIOD  (G_BLINK_PERIOD )  // s
	) uut_inst (
		.i_clk_p (i_clk ),
		.i_clk_n (~i_clk),
		.i_sel   (i_sel ), // MUX selector
		.o_led   (o_led )
	);

endmodule : tb_lab2b_top
