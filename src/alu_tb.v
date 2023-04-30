`timescale 10ns/1ns

module test;
  reg rst_n = 1;
  initial begin
    $dumpfile("build/io_signals.vcd");
    $dumpvars(0, alu_tb);
  end

  reg clk = 0;
  always #10 clk = !clk;

  wire [7:0] value;

  wire [2:0] op;
  reg [15:0] a;
  reg [15:0] b;
  wire [15:0] sum;
  wire overflow;
  wire zero;

  alu alu_tb (clk, rst_n, op, a, b, sum, overflow, zero);

  initial begin
    rst_n = 0;
    #1 rst_n = 1;
    $display("hi!");

    a <= 23485;
    b <= 10234;
    #1 $display("result: 0x%0h", sum);

    $finish;
    
  end

endmodule // test