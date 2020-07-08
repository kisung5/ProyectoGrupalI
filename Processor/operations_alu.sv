module operations_alu #(parameter N=32)(input logic [3:0] opcode,
								  input logic [N-1:0] operandA, operandB,
								  output logic [N-1:0] result,
								  output logic carryout);
								  
								  
		
		
		logic [N-1:0] module_result, adder_result, and_result, subtract_result, 
		multiply_result, concatenate_result ,shiftright_result, shiftleft_result;
		
		logic carry_out, eq_result, neq_result, lt_result, 
		lte_result, gt_result, gte_result;
		
		
		
		
		_module #(N) _module_module (operandA, operandB, module_result);
		
		adder #(N) adder_module (operandA, operandB, adder_result, carry_out);
		
		and_gate #(N) and_module (operandA, operandB, and_result);
		
		subtract #(N) subtract_module (operandA, operandB, subtract_result);
		
		multiply #(N) multiply_module (operandA, operandB, multiply_result);
		
		concatenate #(N) concatenate_module (operandA, operandB, concatenate_result);
		
		shiftright #(N) shiftright_module (operandA, operandB, shiftright_result);
		
		shiftleft #(N) shiftleft_module (operandA, operandB, shiftleft_result);
		
		comparator #(N) comparator_module (operandA, operandB, eq_result, neq_result, lt_result, 
		lte_result, gt_result, gte_result);
		
		
								  
		always @(carryout, operandA, operandB, result)
		begin
			case (opcode)
				// Arithmetic operations
				4'b0000		: begin 						  			// Operation add
									result = adder_result; 
									carryout = carry_out;
								  end
				4'b0001		: result = subtract_result; 		// Operation sub
				4'b0010		: result = multiply_result;	 	// Operation mul
				4'b0011		: result = module_result; 			// Operation mod
				
				// Logic operations
				4'b0100		: result = and_result; 				// Operation and
				4'b0101		: result = concatenate_result; 	// Operation concatenate
				4'b0110		: result = eq_result;				// Compare if two operators are equals
				4'b0111		: result = gt_result; 				// Compare if operandA is greater than operandB
				4'b1000		: result = shiftright_result; 	// Operation srl
				4'b1001		: result = shiftleft_result; 		// Operation sll
				
				default		: result = 32*(1'bx);
			endcase
		end							  
endmodule 