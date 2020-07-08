// Porcessor module, contains basic "sweets" for a pipelined cpu.
// Instruction memory and data memory are out.
module processor
(input logic clk,
input [31:0] inst, // instruction input from inst memory
output [31:0] pcf); // pc address output for inst memory

logic [31:0] inst_fetched; // wire between fdpipe and register bank
logic [3:0] register_src_e; // source register to Execution stage

logic [3:0] alu_control_o, // function code for ALU from the control unit
alu_control_e; // function code for ALU to Execution stage

logic regw_o, alusrc_o, branche_o, memw_o, memtoreg_o, imme_o, // control bits from the control unit
regw_e, alusrc_e, branche_e, memw_e, memtoreg_e, imme_e; // control bits to Execution stage

logic [31:0] pc_adder_mux, // wire adder to PC selector MUX
pc_mux_reg, // wire MUX to PC register
imm_ext_o, // imm wire extended to decode/exe pipe
imm_ext_e; // imm wire in execution stage

logic [31:0] opA_o, opB_o, // operands in point of origin
opA_e, opB_e; // operands in execution stage

// Fetch

// PC register
register #(.N(32)) PC (.wen(), .rst(1'b0), .clk(clk), .in(pc_mux_reg), .out(pcf));

// PC adder for next inst address
adder pc_adder (.operandA(pcf), .operandB(32'b100), .result(pc_adder_mux), .cout());

// Mux selector for PC load data
multiplexer pc_load_select (.d1(pc_adder_mux), .d2(), .d3(), .selector(), .out(pc_mux_reg));

// Fetch/Decode instruction pipelined register
fdpipe fetch_decode (.stall_D(), .flush_F(), .clk(clk), .inst_F(inst), .inst_D(inst_fetched));

// Decode

// Control unit, only operates in decode stage and is a combinational unit.
control_unit control (.opcode(inst_fetched[4:0]), .ALUControl(alu_control_o), .RegW(regw_o), 
.ALUSrc(alusrc_o), .BranchE(branche_o), .MemW(memw_o), .MemtoReg(memtoreg_o), .ImmE(imme_o));

// Instruction immidiate extender to 32 bits
signextend extender (.operand(inst_fetched[31:13]), .result(imm_ext_o));

// Decode/Execution instrucion pipelined register
depipe decode_execution (.flush_E(), .clk(clk),
// input control
.pcload_D(), .regw_D(regw_o), .memw_D(memw_o), .regmem_D(memtoreg_o), .branch_D(branche_o), 
.ALUope_D(alusrc_o), .flag_D(), .ALUctrl_D(alu_control_o),
// input data
.regScr_D(inst_fetched[16:13]), .regA_D(opA_o), .regB_D(opB_o), .inm_D(imm_ext_o),
// output control
.pcload_E(), .regw_E(regw_e), .memw_E(memw_e), .regmem_E(memtoreg_e), .branch_E(branche_e), 
.ALUope_E(alusrc_e), .flag_E(), .ALUctrl_E(alu_control_e),
// output data 
.regScr_E(register_src_e), .regA_E(opA_e), .regB_E(opB_e), .inm_E(imm_ext_e));

// Operand A selector MUX
multiplexer opA_select (.d1(opA_e), .d2(), .d3(), .selector(), .out());

// Operand B selector MUX
multiplexer opB_select (.d1(opB_e), .d2(), .d3(), .selector(), .out());

// ALU
alu alu_unit (.opcode(alu_control_e), .operandA(), .operandB(), .result(),
.C_Flag(), .O_Flag(), .N_Flag(), .Z_Flag());

endmodule 