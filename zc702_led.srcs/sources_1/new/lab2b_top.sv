`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Maxim Kuleshov
// 
// Create Date: 04/10/2024 08:21:56 PM
// Module Name: lab2b_top
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

module lab2b_top #(
	parameter      G_CLK_FREQUENCY = 200e6, // Hz
	parameter int  G_LED_WIDTH     = 8, // bit width of LED "bus"
	parameter int  G_CNT_NUM       = 4, // number of independent counters
	parameter int  G_SEL_WIDTH     = $ceil($clog2(G_CNT_NUM)), // selector bit width
	parameter real G_BLINK_PERIOD [0:G_CNT_NUM-1] = '{1: 2, 2: 3, 3: 4, default:1} // s
) (
	input  wire                    i_clk_p, i_clk_n, // diff clock
	input  wire  [G_SEL_WIDTH-1:0] i_sel, // MUX selector
	output logic [G_LED_WIDTH-1:0] o_led = '1
);

// diff clock input buffer
	IBUFDS #(
		.DIFF_TERM    ("TRUE" ), // Differential Termination
		.IBUF_LOW_PWR ("FALSE"), // Low power="TRUE", Highest performance="FALSE" 
		.IOSTANDARD   ("LVDS" )  // Specify the input I/O standard
	) IBUFDS_inst (
		.I  (i_clk_p ), // Diff_p buffer input (connect directly to top-level port)
		.IB (i_clk_n ), // Diff_n buffer input (connect directly to top-level port)
		.O  (w_clk   )  // Buffer output
	);

	wire [G_CNT_NUM-1:0] w_led;

// LED blinkers
	genvar i;
	generate for (i = 0; i < G_CNT_NUM; i+=1) begin : gen_led
		lab2_led_blink #(
			.G_CLK_FREQUENCY (G_CLK_FREQUENCY  ), // Hz
			.G_BLINK_PERIOD  (G_BLINK_PERIOD[i]), // s
			.G_LED_WIDTH     (1                )
		) u_led (
			.i_clk (w_clk   ),
			.i_rst ('0      ), // reset, active-high
			.o_led (w_led[i])
		);
	end : gen_led endgenerate

// output MUX
	lab1_mux #(
		.G_DAT_WIDTH(G_CNT_NUM)
	) u_mux (
		.i_dat(w_led),
		.i_sel(i_sel),
		.o_res(w_res)
	);

	always @(posedge w_clk)
		o_led <= '{default: w_res};

endmodule : lab2b_top
