module control_unit 
(input logic [4:0] opcode,
output logic [3:0] ALUControl,
output logic RegW, ALUSrc, BranchE, MemW, MemtoReg);
							
logic [4:0] control;
				
				
always_comb
case(opcode)
	5'b00111: control = 5'b10000; // MOD
	5'b00001: control = 5'b10000; // ADD
	5'b00010: control = 5'b10000; // AND
	5'b00011: control = 5'b10000; // SUB
	5'b00100: control = 5'b10000; // MUL
	5'b00101: control = 5'b10000; // CNB
	5'b01000: control = 5'b00100; // BEQ
	5'b01001: control = 5'b00100; // BGT
	5'b10000: control = 5'b11000; // ADDI
	5'b10001: control = 5'b11000; // SRL
	5'b10010: control = 5'b11000; // SLL
	5'b10011: control = 5'b01010; // SB
	5'b10100: control = 5'b11001; // LB
	5'b10101: control = 5'b11001; // LW
	default: control = 5'b00000;
endcase


assign {RegW, ALUSrc, BranchE, MemW, MemtoReg} = control;

// ALU Decoder

always_comb
case(opcode)
	5'b00111: ALUControl = 4'b0011; // MOD
	5'b00001: ALUControl = 4'b0000; // ADD
	5'b00010: ALUControl = 4'b0100; // AND
	5'b00011: ALUControl = 4'b0001; // SUB
	5'b00100: ALUControl = 4'b0010; // MUL
	5'b00101: ALUControl = 4'b0101; // CNB
	5'b10000: ALUControl = 4'b0000; // ADDI
	5'b10001: ALUControl = 4'b1000; // SRL
	5'b10010: ALUControl = 4'b1001; // SLL
	5'b10011: ALUControl = 4'b0000; // SB
	5'b10100: ALUControl = 4'b0000; // LB
	5'b10101: ALUControl = 4'b0000; // LW
//					5'b01000: ALUControl = 4'b0110; // BEQ
	5'b01000: ALUControl = 4'b0000;
//					5'b01001: ALUControl = 4'b0111; // BGT
	5'b01001: ALUControl = 4'b0000;
	default: ALUControl = 4'b0000;
endcase
			
endmodule 