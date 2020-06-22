`timescale 1 ps / 1 ps
module data_memory_tb;

logic clk, wren;
logic [19:0] addr;
logic [7:0] data, q;

// address, clock, data, wren, q

data_memory DUT (.address(addr), .clock(clk), .wren(wren), .data(data), .q(q));

always #1 clk <= ~clk;

initial begin
	clk = 0;
	wren = 0;
	data = 8'b0;
	addr = 20'h0;
	#100;
	#5 addr = 20'h1;
	#100;
end

endmodule 