// Decode-Execution pipeline register
// Important control set:
// flush_E, flush the decoded instrucion
// Inputs and outputs decoded and control results from instruction
module depipe #(parameter N = 32, M = 4)
(input logic flush_E, clk,
input logic pcload_D, regw_D, memw_D, regmem_D, branch_D, ALUope_D, flag_D,
input [M-1:0] ALUctrl_D, regScr_D, inm_D,
input [N-1:0] regA_D, regB_D,
output logic pcload_E, regw_E, memw_E, regmem_E, branch_E, ALUope_E, flag_E,
output [M-1:0] ALUctrl_E, regScr_E, inm_E,
output [N-1:0] regA_E, regB_E);

// Instrucion control flags/bit
register #(.N(1)) pcload (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(pcload_D), .out(pcload_E));
	
register #(.N(1)) regw (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regw_D), .out(regw_E));
	
register #(.N(1)) memw (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(memw_D), .out(memw_E));
	
register #(.N(1)) regmem (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regmem_D), .out(regmem_E));
	
register #(.N(1)) branch (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(branch_D), .out(branch_E));
	
register #(.N(1)) ALUope (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(ALUope_D), .out(ALUope_E));
	
register #(.N(1)) flag (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(flag_D), .out(flag_E));

// ALU control and register data
register #(.N(M)) ALUctrl (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(ALUctrl_D), .out(ALUctrl_E));

register #(.N(M)) regScr (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regScr_D), .out(regScr_E));	

register #(.N(N)) regA (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regA_D), .out(regA_E));

register #(.N(N)) regB (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regB_D), .out(regB_E));

register #(.N(N)) inm (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(inm_D), .out(inm_E));

endmodule 