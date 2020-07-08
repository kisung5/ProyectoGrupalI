module shiftright #(parameter N = 32)(input logic [N-1:0] operandA, operandB,
						  output logic [N-1:0] result);

		assign result = operandA >> operandB;
						  
endmodule
