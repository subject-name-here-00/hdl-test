`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Maxim Kuleshov
// 
// Create Date: 04/10/2024 07:27:16 PM
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

module tb_lab1_mux #(
	parameter int G_DAT_WIDTH = 4,
	parameter int G_SEL_WIDTH = $ceil($clog2(G_DAT_WIDTH))
);

	localparam T_CLK = 20; // TB clock period, ns

// simulate selector
	logic [G_SEL_WIDTH-1:0] i_sel = '0;
	always #(10*T_CLK) i_sel = i_sel + 1;

// simulate all data inputs: define period as linear equation
	logic [G_DAT_WIDTH-1:0] i_dat = '0;

	localparam real C_COEF_A [0:G_DAT_WIDTH-1] = '{0: 0.8, 1: 2.0, 2: 1.5, default: 1.0};
	localparam real C_COEF_B [0:G_DAT_WIDTH-1] = '{1: -5.0, default: 0.0};

	genvar i;
	generate for (i = 0; i < G_DAT_WIDTH; i+=1)
		always #((T_CLK * C_COEF_A[i] + C_COEF_B[i]) / 2)
			i_dat[i] = ~i_dat[i];
	endgenerate

//	always #(T_CLK/2)     i_x[3]=!i_x[3];
//	always #(1.5*T_CLK/2) i_x[2]=!i_x[2];
//	always #((2*T_CLK-5)/2) i_x[1]=!i_x[1];
//	always #(0.8*T_CLK/2) i_x[0]=!i_x[0];

// unit under test (UUT): MUX
	lab1_mux #(
		.G_DAT_WIDTH(G_DAT_WIDTH)
//		.G_SEL_WIDTH(G_SEL_WIDTH) // value is calculated inside the UUT
	) u_uut (
		.i_dat(i_dat),
		.i_sel(i_sel),
		.o_res(o_res)
	);

endmodule : tb_lab1_mux
