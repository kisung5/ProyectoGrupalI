// Memory-Writeback pipeline register
// Inputs and outputs ALU results, registers, and control
module mwpipe #(parameter N = 32, M = 4)
(input logic clk,
input logic pcload_M, regw_M, regmem_M,
input [M-1:0] regScr_M,
input [N-1:0] ALUrslt_M,
output logic pcload_W, regw_W, regmem_W,
output [M-1:0] regScr_W,
output [N-1:0] ALUrslt_W);

// Instrucion control flags/bit
register #(.N(1)) pcload (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(pcload_M), .out(pcload_W));
	
register #(.N(1)) regw (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(regw_M), .out(regw_W));
	
register #(.N(1)) regmem (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(regmem_M), .out(regmem_W));
	
// ALU result and register data
register #(.N(M)) regScr (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(regScr_M), .out(regScr_W));	

register #(.N(N)) ALUrslt (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(ALUrslt_M), .out(ALUrslt_W));

endmodule 