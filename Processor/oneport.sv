module oneport(
input logic clk,
input logic [18:0] aa,
input logic [7:0] da,
input logic wa,
output logic [7:0] qa);

logic [7:0] mem [460800:0];

always_ff @(posedge clk) begin
	if (wa) begin
		mem[aa] <= da;
	end else 
		qa <= mem[aa];
end

endmodule
