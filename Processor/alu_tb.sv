module alu_tb #(parameter N = 32);

logic [N-1:0] operandA, operandB, result;
logic [2:0] opcode;
logic C_Flag, O_Flag, N_Flag, Z_Flag;


//Comparator #(32) comparador (operandA,operandB, result);
alu #(N) alu_module (opcode, operandA, operandB, result, C_Flag, O_Flag, N_Flag, Z_Flag);


initial begin
// ALU Tests
// Flags
// Zero flag
operandA = 32'd32; operandB = 32'd32; opcode = 3'b000; #10;
// Negative flag		
operandA = 32'd64; operandB = 32'd64; opcode = 3'b001; #10;
// Overflow flag
operandA = 32'b01; operandB = 32'b10; opcode = 3'b100; #10;	
end

endmodule
