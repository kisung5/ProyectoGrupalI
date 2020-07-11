module Reg_bank(input logic clk, rst,
					input logic we3,
					input logic [3:0] ra1, ra2, wa3,
					input logic [31:0] wd3,
					output logic [31:0] rd1, rd2);

logic [31:0] rf [14:0];
integer i;

always_ff @(posedge clk)
begin
	if (rst)
		begin
        for (i=0; i<15; i=i+1) rf[i] <= 32'b0;
      end 
	else if (we3) 
		rf[wa3] <= wd3;
end

assign rd1 = rf[ra1];

assign rd2 = rf[ra2];

endmodule 