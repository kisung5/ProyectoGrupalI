// Execution-Memory pipeline register
// Inputs and outputs ALU results, registers, address, and control
module empipe #(parameter N = 32, M = 4)
(input logic clk,
input logic pcload_E, regw_E, memw_E, regmem_E,
input [M-1:0] regScr_E,
input [N-1:0] ALUrslt_E, address_E,
output logic pcload_M, regw_M, memw_M, regmem_M,
output [M-1:0] regScr_M,
output [N-1:0] ALUrslt_M, address_M);

// Instrucion control flags/bit
register #(.N(1)) pcload (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(pcload_E), .out(pcload_M));
	
register #(.N(1)) regw (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(regw_E), .out(regw_M));
	
register #(.N(1)) memw (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(memw_E), .out(memw_M));
	
register #(.N(1)) regmem (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(regmem_E), .out(regmem_M));
	
// ALU result, register and address data
register #(.N(M)) regScr (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(regScr_E), .out(regScr_M));	

register #(.N(N)) ALUrslt (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(ALUrslt_E), .out(ALUrslt_M));

register #(.N(N)) address (.wen(1'b1), .rst(1'b0), .clk(clk), 
	.in(address_E), .out(address_M));

endmodule 