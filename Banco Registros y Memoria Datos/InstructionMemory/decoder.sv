module decoder(input logic [4:0] Op,
               input logic [3:0] Rd,
               output logic [1:0] FlagW,
               output logic PCS, RegW, MemW,
               output logic MemtoReg, ALUSrc,
               output logic [2:0] ImmSrc, RegSrc, ALUControl);

logic [9:0] controls;
logic Branch, ALUOp;

// Main Decoder
always_comb

casex(Op)

				// Data-processing immediate
	
	2'b00:
		if (Funct[5]) controls = 10'b0000101001;
		
				// Data-processing register
		
		else controls = 10'b0000001001;

				// Load functions
	
	2'b01:
		if (Funct[0]) controls = 10'b0001111000;
		
				// Store functions
				
		else controls = 10'b1001110100;
		
				// Branch
	
	2'b10: controls = 10'b0110100010;
	
	// Unimplemented
	default: controls = 10'bx;
	
endcase
	
assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, RegW, MemW, Branch, ALUOp} = controls;
	
// ALU Decoder

always_comb

if (ALUOp) begin

	case(Funct[4:1])
	
		4'b0100: ALUControl = 3'b000; // ADD
		4'b0010: ALUControl = 3'b001; // SUB
		4'b0000: ALUControl = 3'b010; // MOD
		4'b1100: ALUControl = 3'b011; // MUL
		4'b1100: ALUControl = 3'b100; // AND
		default: ALUControl = 3'bx;  // unimplemented
		
	endcase
		
	// update flags if S bit is set (C & V only for arith)
	
	FlagW[1] = Funct[0];
	FlagW[0] = Funct[0] & (ALUControl == 3'b000 | ALUControl == 3'b001);
	
end else begin

	ALUControl = 3'b000; // add for non-DP instructions
	
	FlagW = 2'b00; // don't update Flags
	
end

// PC Logic

assign PCS = ((Rd == 4'b1111) & RegW) | Branch;

endmodule