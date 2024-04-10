`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Maxim Kuleshov
// 
// Create Date: 04/10/2024 07:21:17 PM
// Module Name: lab1_mux
// Target Devices: zc702
// Description: simple MUX -- multiple inputs, single output
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab1_mux #(
	parameter int G_DAT_WIDTH = 4,
	parameter int G_SEL_WIDTH = $ceil($clog2(G_DAT_WIDTH))
) (
	input  wire  [G_DAT_WIDTH-1:0] i_dat,
	input  wire  [G_SEL_WIDTH-1:0] i_sel,
	output logic                   o_res
);

//// reverse order: direct approach
//	assign o_res = i_dat[G_DAT_WIDTH - i_sel - 1];

// Gray code order: using "if-else-if"
	always_comb
		if (i_sel == 0)
			o_res = i_dat[0];
		else if (i_sel == 1)
			o_res = i_dat[1];
		else if (i_sel == 2)
			o_res = i_dat[3];
		else if (i_sel == 3)
			o_res = i_dat[2];

endmodule : lab1_mux
