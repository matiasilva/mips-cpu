// carry look ahead adder
`include "src/4bitadder.v"

module alu (clk, rst_n, op, a, b, sum, overflow, zero);

	parameter N_ADDERS = 4;

	input wire clk;
	input wire rst_n;
	input wire [2 : 0] op;
	input wire [15 : 0] a;
	input wire [15 : 0] b;

	output wire [15 : 0] sum;
	output wire overflow;
	output wire zero;

	genvar i;
	generate
		for (i = 0; i < N_ADDERS; i = i + 1) begin
			adder u0 (.a(a[i*4 +: 4]), .b(b[i*4 +: 4]), .cin(cin[i]), .sum(sum[i*4 +: 4]), .g(g[i]), .p(p[i]));
		end
	endgenerate

	// look-ahead logic
	reg c0 = 0;
	wire [N_ADDERS: 0] cin;
	wire [N_ADDERS - 1: 0] g;
	wire [N_ADDERS - 1: 0] p;

	assign cin[0] = c0;
	assign cin[1] = g[0] | (p[0] & cin[0]);
	assign cin[2] = g[1] | (g[0] & p[1]) | (&p[1:0] & cin[0]);
	assign cin[3] = g[2] | (g[1] & p[2]) | (g[0] & &p[2:1]) | (&p[2:0] & cin[0]);
	assign cin[4] = g[3] & (g[2] & p[3]) | (g[1] & &p[3:2]) | (g[0] & &p[3:1]) | (&p[3:0] & cin[0]);


/*	localparam AND_OP = 3'b000;
	localparam OR_OP  = 3'b001;
	localparam ADD_OP = 3'b010;
	localparam SUB_OP = 3'b011;
	localparam SLT_OP = 3'b100;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			result <= 0;
		end else begin
			case(op)
				and_op:
					result <= a & b;
				or_op:
					result <= a | b;
				add_op:
					result <= sum;
				sub_op:
					result <= a - b;
				slt_op:
					result <= {31{1'b0}, (a-b)[WIDTH-1]};
			endcase
		end
	end*/


endmodule