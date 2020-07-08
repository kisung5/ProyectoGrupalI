module Instr_mem(input logic [31:0] a,
					output logic [31:0] rd);

logic [31:0] RAM[23:0];

initial

	$readmemh("C:/intelFPGA_lite/18.1/TB/memfile.txt",RAM);
	
assign rd = RAM[a[31:2]];

endmodule