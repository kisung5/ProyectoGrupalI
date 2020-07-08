module Reg_bank_tb ();

logic clk, we3;
logic [3:0] ra1, ra2, wa3;
logic [31:0] wd3, r15, rd1, rd2;

Reg_bank DUT (.clk(clk), .we3(we3), 
.ra1(ra1), .ra2(ra2), .wa3(wa3),
.wd3(wd3), .r15(r15),
.rd1(rd1), .rd2(rd2));

always #10 clk <= ~clk;

initial begin
	clk = 0;
	we3 = 0;
	ra1 = 4'b0; 
	ra2 = 4'b0;
	wa3 = 4'b0;
	wd3 = 32'b0;
	r15 = 32'b0;
	//rd1 = 32'b0;
	//rd2 = 32'b0;
	#5 ra1 = 4'h1;
	ra2 = 4'h1;
	#20 wa3 = 4'h0;
	we3 = 1;
	wd3 = 32'hFF;
	#20 we3 = 1'b0;
	ra1 = 4'h0;
end

endmodule 