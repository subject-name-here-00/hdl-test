`timescale 1ns / 1ps
// FSM example
// v1.0, 15.04.2024
module lab3_fsm #(
	int G_NUM = 1 // number of traffic lights / sensors
) (
	input  wire              i_clk     , // clock
	input  wire              i_rst_p   , // reset, active-high
	input  wire  [G_NUM-1:0] i_snsr_val, // data from sensors
	output logic [G_NUM-1:0] o_trfl_val = '0 // traffic lights control signals
);

typedef enum {
	S0_READY,
	S1_BUSY
} t_fsm_states;

t_fsm_states w_next_state, q_crnt_state;

localparam C_CNT_WID = 4;
logic [C_CNT_WID-1:0] q_timeout_cnt = '1;

// FSM next state decode
	always_comb begin
		w_next_state = q_crnt_state;
		case (q_crnt_state)
			S0_READY: w_next_state = (i_snsr_val == 1)    ? S1_BUSY  : S0_READY;
			S1_BUSY : w_next_state = (q_timeout_cnt == 0) ? S0_READY : S1_BUSY ;
		endcase
	end

// FSM current state sync
	always_ff @(posedge i_clk)
		q_crnt_state <= (i_rst_p) ? S0_READY : w_next_state;

// timeout counter
	always_ff @(posedge i_clk)
		if (q_crnt_state == S1_BUSY)
			q_timeout_cnt <= q_timeout_cnt - 1;
		else
			q_timeout_cnt <= '1;

// FSM output decode
	always_ff @(posedge i_clk)
		o_trfl_val[0] <= (q_crnt_state == S1_BUSY);

endmodule : lab3_fsm
