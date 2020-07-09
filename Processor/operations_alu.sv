module operations_alu #(parameter N=32)
(input [3:0] opcode,
input logic [N-1:0] operandA, operandB,
output logic [N-1:0] result,
output logic carryout);
								  

//logic [N-1:0] module_result, adder_result, and_result, subtract_result, 
//multiply_result, concatenate_result ,shiftright_result, shiftleft_result;

logic carry_out; // eq_result, neq_result, lt_result, 
//lte_result, gt_result, gte_result;

								  
always_comb //@(opcode, operandA, operandB)
begin
	case (opcode)
		// Arithmetic operations
		4'b0000 : 
			begin // Operation add
				{carryout, result} <= operandA + operandB;
//				result <= adder_result; 
//				carryout <= carry_out;
			end
		4'b0001 : 
			begin // Operation sub
				result <= operandA - operandB;
//				result <= subtract_result;
				carryout <= 1'b0;
			end
		4'b0010 : 
			begin // Operation mul
				result <= operandA * operandB;
//				result <= multiply_result;
				carryout <= 1'b0;
			end
		4'b0011 : 
			begin // Operation mod
				result <= operandA % operandB;
//				result <= module_result;
				carryout <= 1'b0;
			end

		// Logic operations
		4'b0100 : 
			begin // Operation and
//				result <= and_result;
				result <= operandA && operandB;
				carryout <= 1'b0;
			end
		4'b0101 : 
			begin // Operation concatenate
//				result <= concatenate_result;
				result <= {16'b0, operandA[7:0], operandB[7:0]};
				carryout <= 1'b0;
			end
		
		4'b1000 : 
			begin // Operation srl
//				result <= shiftright_result;
				result <= operandA >> operandB;
				carryout <= 1'b0;
			end

		4'b1001 : 
			begin // Operation sll
//				result <= shiftleft_result;
				result <= operandA << operandB;
				carryout <= 1'b0;
			end
		
		// Comparations for branches, included in the ALU bur couldn't put a result.
//		4'b0110 : result <= eq_result;				// Compare if two operators are equals
//		4'b0111 : result <= gt_result; 				// Compare if operandA is greater than operandB
		
		default :
			begin
				result <= 32'b0; 
				carryout <= 1'b0;
			end
	endcase
end

//_module #(N) _module_module (operandA, operandB, module_result);
//
//adder #(N) adder_module (operandA, operandB, adder_result, carry_out);
//
//and_gate #(N) and_module (operandA, operandB, and_result);
//
//subtract #(N) subtract_module (operandA, operandB, subtract_result);
//
//multiply #(N) multiply_module (operandA, operandB, multiply_result);
//
//concatenate #(N) concatenate_module (operandA, operandB, concatenate_result);
//
//shiftright #(N) shiftright_module (operandA, operandB, shiftright_result);
//
//shiftleft #(N) shiftleft_module (operandA, operandB, shiftleft_result);
//
//comparator #(N) comparator_module (operandA, operandB, eq_result, neq_result, lt_result, 
//lte_result, gt_result, gte_result);
endmodule 