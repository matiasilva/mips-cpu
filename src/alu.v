module alu (clk, rst_n, op, a, b, result, overflow, zero);

	parameter WIDTH;
	parameter OP_WIDTH;

	input wire clk;
	input wire rst_n;
	input wire [OP_WIDTH-1 : 0] op;
	input reg [WIDTH-1 : 0] a;
	input reg [WIDTH-1 : 0] b;

	output reg [WIDTH-1 : 0] result;
	output wire overflow;
	output wire zero;

	wire [WIDTH - 1: 0] sum;
	assign {overflow, sum} = a + b;
	assign zero = &sum;

	localparam and_op = 3'b000;
	localparam or_op  = 3'b001;
	localparam add_op = 3'b010;
	localparam sub_op = 3'b011;
	localparam slt_op = 3'b100;

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
	end


endmodule