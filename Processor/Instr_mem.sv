module Instr_mem(input logic [31:0] a,
					output logic [31:0] rd);

logic [31:0] RAM [100:0];
logic [31:0] data;

assign rd = data;

initial
	$readmemb("RSA_Decrypt.b",RAM);

always @(a)
begin : MEM_READ
	data <= RAM[a[31:2]];
end

endmodule 