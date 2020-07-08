module mwpipe_tb;

logic clk, rst, pcload_in, regw_in, regmem_in;
logic pcload_out, regw_out, regmem_out;
logic [3:0] regScr_in, regScr_out;
logic [31:0] ALUrslt_in, ALUrslt_out;

// address, clock, data, wren, q

mwpipe DUT (.clk(clk), .rst(rst), 
	.pcload_M(pcload_in), .regw_M(regw_in), .regmem_M(regmem_in), 
	.regScr_M(regScr_in), .ALUrslt_M(ALUrslt_in),
	.pcload_W(pcload_out), .regw_W(regw_out), .regmem_W(regmem_out), 
	.regScr_W(regScr_out), .ALUrslt_W(ALUrslt_out));

always #10 clk <= ~clk;

initial begin
	clk = 0;
	pcload_in = 0; 
	regw_in = 0; 
	regmem_in = 0;
	regScr_in = 4'b0;
	ALUrslt_in = 32'b0;
	#55;
	#20 pcload_in = 1;
	regw_in = 1; 
	regmem_in = 0; 
	regScr_in = 4'b0011;
	ALUrslt_in = 32'h0000FFFF; 
	#20 pcload_in = 0;
	regw_in = 1;
	regmem_in = 0; 
	regScr_in = 4'b0100;
	ALUrslt_in = 32'h0000FFFF; 
	#100;
end

endmodule 