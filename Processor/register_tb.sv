module register_tb;

logic clk, wen, rst;
logic [7:0] in, out;

register DUT(.wen(wen), .clk(clk), .rst(rst), .in(in), .out(out));

always #10 clk <= ~clk;

initial begin
	clk = 0;
	rst = 0;
	in = 8'b00000000;
	out = 8'b00000000;
	#5 rst = 1;
	#5 rst = 0;
	#5 wen = 1;
	#100;
	#5 in = 8'b01011100;
	#100;
	#5 wen = 0;
	#5 in = 8'b00001010;
	#100;
	#5 wen = 1;
	#20;
	#5 rst = 1;
	#100;
end

endmodule
