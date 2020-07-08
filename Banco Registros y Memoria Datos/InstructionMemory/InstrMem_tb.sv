module InstrMem_tb();

logic clk;
logic [31:0]a;
logic [31:0]rd;

Instr_mem imem(a,rd);

initial

begin
	
	a = 32'b001;
	
end


always

begin

clk <= 1; # 5; clk <= 0; # 5;

end

endmodule