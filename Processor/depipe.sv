// Decode-Execution pipeline register
// Important control set:
// flush_E, flush the decoded instrucion
// Inputs and outputs decoded and control results from instruction
module depipe #(parameter N = 32, M = 4, L = 3)
(input logic flush_E, clk,
input logic regw_D, memw_D, regmem_D, ALUope_D,
input [L-1:0] ALUctrl_D, 
input [M-1:0] regScr_D, regAD, regBD,
input [N-1:0] regA_D, regB_D, inm_D,
output logic regw_E, memw_E, regmem_E, ALUope_E,
output [L-1:0] ALUctrl_E, 
output [M-1:0] regScr_E, regAE, regBE,
output [N-1:0] regA_E, regB_E, inm_E);

// Instrucion control flags/bit
register #(.N(1)) regw (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regw_D), .out(regw_E));
	
register #(.N(1)) memw (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(memw_D), .out(memw_E));
	
register #(.N(1)) regmem (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regmem_D), .out(regmem_E));
	
register #(.N(1)) ALUope (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(ALUope_D), .out(ALUope_E));

// ALU control and register data
register #(.N(L)) ALUctrl (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(ALUctrl_D), .out(ALUctrl_E));

register #(.N(M)) regScr (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regScr_D), .out(regScr_E));
	
register #(.N(M)) regA_o (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regAD), .out(regAE));
	
register #(.N(M)) regB_o (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regBD), .out(regBE));

register #(.N(N)) regA (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regA_D), .out(regA_E));

register #(.N(N)) regB (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(regB_D), .out(regB_E));

register #(.N(N)) inm (.wen(1'b1), .rst(flush_E), .clk(clk), 
	.in(inm_D), .out(inm_E));

endmodule 