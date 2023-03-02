`timescale 10ns/10ns;

module test;
  reg rst_n = 1;
  initial begin
    $dumpfile("build/io_signals.vcd");
    $dumpvars(0, alu);
  end

  reg clk = 0;
  always #10 clk = !clk;

  wire [7:0] value;

  wire [OP_WIDTH-1:0] op;
  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] result;
  wire overflow;
  wire zero;
  alu #(.WIDTH(32), .OP_WIDTH(3)) alu_tb (.clk(clk), .rst_n(rst_n), .op(op), .a(a), .b(b), .result(result), .overflow(overflow), .zero(zero));

  initial begin
    rst_n = 0;
    #10 rst_n = 1;
  end

endmodule // test