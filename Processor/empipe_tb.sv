module empipe_tb;

logic clk, pcload_in, regw_in, memw_in, regmem_in;
logic pcload_out, regw_out, memw_out, regmem_out;
logic [3:0] regScr_in, regScr_out;
logic [31:0] ALUrslt_in, address_in, ALUrslt_out, address_out;

// address, clock, data, wren, q

empipe DUT (.clk(clk), 
	.pcload_E(pcload_in), .regw_E(regw_in), .memw_E(memw_in), .regmem_E(regmem_in), 
	.regScr_E(regScr_in), .ALUrslt_E(ALUrslt_in), .address_E(address_in),
	.pcload_M(pcload_out), .regw_M(regw_out), .memw_M(memw_out), .regmem_M(regmem_out), 
	.regScr_M(regScr_out), .ALUrslt_M(ALUrslt_out), .address_M(address_out));

always #10 clk <= ~clk;

initial begin
	clk = 0;
	pcload_in = 0; 
	regw_in = 0; 
	memw_in = 0;
	regmem_in = 0;
	regScr_in = 4'b0;
	ALUrslt_in = 32'b0;
	address_in = 32'b0;
	#55;
	#20 pcload_in = 1;
	regw_in = 1; 
	memw_in = 0;
	regmem_in = 0; 
	regScr_in = 4'b0011;
	ALUrslt_in = 32'h0000FFFF; 
	address_in = 32'h00010004;
	#20 pcload_in = 0;
	regw_in = 1; 
	memw_in = 0;
	regmem_in = 0; 
	regScr_in = 4'b0100;
	ALUrslt_in = 32'h0000FFFF;
	address_in = 32'h00000000;
end

endmodule 