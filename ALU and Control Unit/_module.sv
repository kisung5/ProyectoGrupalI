module _module #(parameter N = 32) (input logic [N-1:0] operand, _module,
									 output logic [N-1:0] result);
									 
		assign result = operand % _module;
		
									 
endmodule