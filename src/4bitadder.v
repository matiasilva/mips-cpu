module adder(a, b, cin, sum, g, p);

	input wire [3:0] a;
	input wire [3:0] b;
	input wire cin;

	output wire [3:0] sum;
	output wire p;
	output wire g;

	wire [3:0] gb;
	assign gb = a & b;
	wire [3:0] pb;
	assign pb = a | b;

	assign sum = {{3{1'b0}}, cin} + a + b;
	assign p = &pb;
	assign g = gb[3] | (pb[3] & gb[2]) | (&pb[3:2] & gb[1]) | (&pb[3:1] & gb[0]);

endmodule