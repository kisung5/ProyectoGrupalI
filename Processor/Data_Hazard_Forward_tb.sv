module Data_Hazard_Forward_tb ();

	logic [3:0] R1_E, R2_E, Rd_M, Rd_WB;
	logic [1:0] S_Hazard_A, S_Hazard_B;
	Data_Hazard_Forward Data_Hazard_A (R1_E, Rd_M, Rd_WB, S_Hazard_A);
	Data_Hazard_Forward Data_Hazard_B (R2_E, Rd_M, Rd_WB, S_Hazard_B);
	
	
	initial begin
		
		R1_E = 4'b0001; Rd_M = 4'b0001; Rd_WB = 4'b0000; #10;
		R2_E = 4'b0001; Rd_M = 4'b0001; Rd_WB = 4'b0000; #10;
	
	end
	

endmodule
