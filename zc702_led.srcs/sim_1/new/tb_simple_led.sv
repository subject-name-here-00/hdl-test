`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Maxim Kuleshov
// 
// Create Date: 04/04/2024 08:52:41 AM
// Module Name: tb_simple_led
// Target Devices: Xilinx
// Tool Versions: SV 2012
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_simple_led ();

// UUT generics
	localparam     G_CLK_FREQUENCY = 1e9; // Hz
	localparam     G_BLINK_PERIOD  = 100e-9; // s
	localparam int G_LED_WIDTH     = 5;

// TB constants
	localparam     T_CLK = 1e9 / G_CLK_FREQUENCY; // ns
	localparam     G_REP_NUM = 2; // number of UUT replicas

// UUT i/o signals
	logic                             i_clk = '0;
	logic [G_REP_NUM-1:0]             i_rst = '0; // reset, active-high
	logic [G_REP_NUM*G_LED_WIDTH-1:0] o_led = '0;

	always #(T_CLK / 2.0) i_clk = ~i_clk; // simulate clock

// simulate reset, active-high
	initial begin
		i_rst[0] = 0;
		#400 i_rst[0] = 1;
		#100 i_rst[0] = 0;
	end

// unit under test (UUT): LED blink control
	simple_led #(
			.G_CLK_FREQUENCY (G_CLK_FREQUENCY), // Hz
			.G_BLINK_PERIOD  (G_BLINK_PERIOD ), // s
			.G_LED_WIDTH     (G_LED_WIDTH    )
		) uut [G_REP_NUM-1:0] (
			.i_clk (i_clk),
			.i_rst (i_rst), // reset, active-high
			.o_led (o_led)
		);

endmodule : tb_simple_led
