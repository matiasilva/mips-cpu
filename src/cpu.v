module cpu(clk, rst_n);

  parameter REG_WIDTH = 32;
  parameter ALU_OP_WIDTH = 3;

  input wire clk;
  input wire rst_n;

  reg [WIDTH-1 : 0]   pc;

  // alu connections
  wire [ALU_OP_WIDTH-1:0] alu_op      ;
  reg  [   REG_WIDTH-1:0] alu_a       ;
  reg  [   REG_WIDTH-1:0] alu_b       ;
  reg  [   REG_WIDTH-1:0] alu_out     ;
  wire                    alu_overflow;
  wire                    alu_zero    ;


  alu #(.WIDTH(REG_WIDTH), .OP_WIDTH(ALU_OP_WIDTH)) alu_core (
    .clk     (clk         ),
    .rst_n   (rst_n       ),
    .a       (alu_a       ),
    .b       (alu_b       ),
    .result  (alu_out     ),
    .overflow(alu_overflow),
    .zero    (alu_zero    )
  );

  always @(posedge clk or negedge rst_n)
    if (~rst_n)
      out <= 0;
    else
      out <= out + 1;

endmodule