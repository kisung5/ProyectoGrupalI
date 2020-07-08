module Instruction_memory(input logic clk,
								input  logic [31:0] instruc,
								output logic [31:0] rd);

logic [31:0] RAM[50:0];

initial
 
	begin
	
    $readmemh("memfile.dat",RAM);
	
	end

assign rd = RAM[instruc[31:2]];

endmodule 