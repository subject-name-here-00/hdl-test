`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Maxim Kuleshov
// 
// Create Date: 04/10/2024 08:29:43 PM
// Module Name: lab2b_led_blink
// Target Devices: zc702
// Description: drop frequency and period parameters -- use counter's radix
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab2b_led_blink #(
	parameter G_CNT_WIDTH = 8,
	parameter G_LED_WIDTH = 4
) (
	input  wire                    i_clk,
	input  wire                    i_rst, // reset, active-high
	output logic [G_LED_WIDTH-1:0] o_led
);

// clock cycles counter
	reg [G_CNT_WIDTH-1:0] q_cnt = '0;
	always @(posedge i_clk)
		q_cnt <= (q_rst) ? '0 : q_cnt - 1;

	assign o_led = '{default: q_cnt[G_CNT_WIDTH-1]};

endmodule : lab2b_led_blink
