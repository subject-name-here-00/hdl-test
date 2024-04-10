`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Maxim Kuleshov
// 
// Create Date: 04/10/2024 08:13:41 PM
// Module Name: lab2a_top
// Target Devices: zc702
// Description: replicate LED blinker twice
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab2a_top #(
	parameter     G_CLK_FREQUENCY = 200e6, // Hz
	parameter     G_BLINK_PERIOD  = 1, // s
	parameter int G_LED_WIDTH     = 4, // bit width of single LED "bus"
	parameter int G_REP_NUM       = 2  // number of LED control units replicas
) (
	input  wire                              i_clk_p, i_clk_n, // diff clock
	input  wire  [G_REP_NUM-1:0]             i_rst, // reset, active-high
	output logic [G_REP_NUM*G_LED_WIDTH-1:0] o_led
);

// diff clock input buffer
	IBUFDS #(
		.DIFF_TERM    ("TRUE" ), // Differential Termination
		.IBUF_LOW_PWR ("FALSE"), // Low power="TRUE", Highest performance="FALSE" 
		.IOSTANDARD   ("LVDS" )  // Specify the input I/O standard
	) IBUFDS_inst (
		.I  (i_clk_p ), // Diff_p buffer input (connect directly to top-level port)
		.IB (i_clk_n ), // Diff_n buffer input (connect directly to top-level port)
		.O  (w_clk_in)  // Buffer output
	);

//// global clock buffer (added automatically)
//	BUFG BUFG_inst (
//		.I (w_clk_in), // 1-bit input: Clock input
//		.O (w_clk_g )  // 1-bit output: Clock output
//	);

	assign w_clk_g = w_clk_in;

// LED control unit
	lab2_led_blink #(
		.G_CLK_FREQUENCY (G_CLK_FREQUENCY), // Hz
		.G_BLINK_PERIOD  (G_BLINK_PERIOD ), // s
		.G_LED_WIDTH     (G_LED_WIDTH    )
	) led_inst [G_REP_NUM-1:0] (
		.i_clk (w_clk_g),
		.i_rst (i_rst  ), // reset, active-high
		.o_led (o_led  )
	);

endmodule : lab2a_top
