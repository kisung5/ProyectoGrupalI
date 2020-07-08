module Instr_mem_tb();

logic clk;
logic [31:0] a;
logic [31:0] rd;

Instr_mem DUT(a, rd);

always #10 clk <= ~clk;

initial begin
	#5 a = 32'b0;
	#10;
	a = 32'b1;
end

endmodule 