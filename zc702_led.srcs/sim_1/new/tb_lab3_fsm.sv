`timescale 1ns / 1ps
// FSM example
// v1.0, 15.04.2024
module tb_lab3_fsm #(
// UUT generics
	int G_NUM = 1, // number of traffic lights / sensors
	
// TB constants
	T_CLK = 1.0 // ns
);

	logic             i_clk      = '0; // clock
	logic             i_rst_p    = '0; // reset, active-high
	logic [G_NUM-1:0] i_snsr_val = '0; // data from sensors
	logic [G_NUM-1:0] o_trfl_val = '0; // traffic lights control signals

// simulate clock
	always #(T_CLK/2.0) i_clk = ~i_clk;

// simulate daat from sensors
	always #(40*T_CLK) i_snsr_val += 1;

// unit under test (UUT): FSM test
	lab3_fsm #(
		.G_NUM (G_NUM) // number of traffic lights / sensors
	) u_uut (
		.i_clk      (i_clk     ), // clock
		.i_rst_p    (i_rst_p   ), // reset, active-high
		.i_snsr_val (i_snsr_val), // data from sensors
		.o_trfl_val (o_trfl_val)  // traffic lights control signals
	);

endmodule : tb_lab3_fsm
