module depipe_tb;

logic clk, flush, pcload_in, regw_in, memw_in, regmem_in, branch_in, ALUope_in, flag_in;
logic pcload_out, regw_out, memw_out, regmem_out, branch_out, ALUope_out, flag_out;
logic [3:0] ALUctrl_in, regScr_in, ALUctrl_out, regScr_out;
logic [31:0] regA_in, regB_in, regA_out, regB_out;
logic [18:0] inm_in, inm_out;

// address, clock, data, wren, q

depipe DUT (.clk(clk), .flush_E(flush), 
	.pcload_D(pcload_in), .regw_D(regw_in), .memw_D(memw_in), .regmem_D(regmem_in), 
	.branch_D(branch_in), .ALUope_D(ALUope_in), .flag_D(flag_in), .ALUctrl_D(ALUctrl_in), 
	.regScr_D(regScr_in), .regA_D(regA_in), .regB_D(regB_in), .inm_D(inm_in), 
	.pcload_E(pcload_out), .regw_E(regw_out), .memw_E(memw_out), .regmem_E(regmem_out), 
	.branch_E(branch_out), .ALUope_E(ALUope_out), .flag_E(flag_out), .ALUctrl_E(ALUctrl_out), 
	.regScr_E(regScr_out), .regA_E(regA_out), .regB_E(regB_out), .inm_E(inm_out));

always #10 clk <= ~clk;

initial begin
	clk = 0;
	flush = 0;
	pcload_in = 0; 
	regw_in = 0; 
	memw_in = 0;
	regmem_in = 0; 
	branch_in = 0; 
	ALUope_in = 0; 
	flag_in = 0;
	ALUctrl_in = 4'b0; 
	regScr_in = 4'b0;
	regA_in = 32'b0; 
	regB_in = 32'b0;
	inm_in = 19'b0;
	#50;
	#5 pcload_in = 1;
	regw_in = 1; 
	memw_in = 0;
	regmem_in = 0; 
	branch_in = 1; 
	ALUope_in = 0; 
	flag_in = 1;
	ALUctrl_in = 4'b0101; 
	regScr_in = 4'b0011;
	regA_in = 32'h0000FFFF; 
	regB_in = 32'h00000801;
	inm_in = 19'h00000;
	#5;
	#5 pcload_in = 0;
	regw_in = 1; 
	memw_in = 0;
	regmem_in = 0; 
	branch_in = 0; 
	ALUope_in = 1; 
	flag_in = 0;
	ALUctrl_in = 4'b0010; 
	regScr_in = 4'b0100;
	regA_in = 32'h0000FFFF; 
	regB_in = 32'h00000000;
	inm_in = 19'h00401;
	#5;
	#5 flush = 1;
	#50;
end

endmodule 