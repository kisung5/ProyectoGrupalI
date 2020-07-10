// Permite adelantar los datos hasta la etapa de execute, idependientemente del operando, ya que se hizo
// general.
// Inputs: Reg_E -> ID del registro operando en execute
// Rd_M -> ID del registro destino en mem
// Rd_WB -> ID del registro destino en wb
// Output: S_Hazard: Selección del operando para los multiplexores.
module Data_Hazard_Forward #(parameter N = 4)(input logic [N-1:0] Reg_E, Rd_M, Rd_WB,
															  output logic [1:0] S_Hazard);

	logic [1:0] result;
	
	always_comb
	begin
		if (Rd_M == Reg_E) result = 2'b01;
		else if (Rd_WB == Reg_E) result = 2'b10;
		else
		begin
			result = 2'b00;
		end
	end
		
	assign S_Hazard = result;
endmodule
	