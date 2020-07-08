module shiftleft #(parameter N = 32) (input logic [N-1:0] operand, shamt,
												  output logic [N-1:0] result);

		assign result = operand << shamt;
												  
endmodule
