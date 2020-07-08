module signextend #(parameter N = 32) (input logic [18:0] operand,
									 output logic [N-1:0] result);
									 
		assign result = {13*operand[18], operand};
									 
endmodule
