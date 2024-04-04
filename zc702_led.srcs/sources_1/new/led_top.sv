`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Maxim Kuleshov
// 
// Create Date: 04/04/2024 09:20:01 AM
// Module Name: led_top
// Target Devices: Xilinx
// Tool Versions: SV 2012
// Description: LEDs blink control
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module led_top #(
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

// global clock buffer
	BUFG BUFG_inst (
			.I (w_clk_in), // 1-bit input: Clock input
			.O (w_clk_g )  // 1-bit output: Clock output
		);

// LED control unit
	simple_led #(
			.G_CLK_FREQUENCY (G_CLK_FREQUENCY), // Hz
			.G_BLINK_PERIOD  (G_BLINK_PERIOD ), // s
			.G_LED_WIDTH     (G_LED_WIDTH    )
		) u_led_ctrl [G_REP_NUM-1:0] (
			.i_clk (w_clk_g),
			.i_rst (i_rst  ), // reset, active-high
			.o_led (o_led  )
		);

endmodule : led_top