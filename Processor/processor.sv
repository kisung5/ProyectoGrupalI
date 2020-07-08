// Porcessor module, contains basic "sweets" for a pipelined cpu.
// Instruction memory and data memory are outside of this module.
module processor
(input logic clk,
input [31:0] inst, // instruction input from inst memory
data, // data input from data memory
output logic memw_m, // memory write enable output control
output [31:0] pcf, // pc address output to inst memory
m_address, // memory address output to data memory
m_data); // data output to data memory

// %% List of connections/wires in the processor %%

logic [31:0] inst_fetched; // wire between fdpipe and register bank
logic [3:0] register_src_e, // source register to Execution stage
register_src_m, // source register to Memory stage
register_src_w; // source register to Writeback stage

logic [3:0] alu_control_o, // function code for ALU from the control unit
alu_control_e; // function code for ALU to Execution stage

logic regw_o, alusrc_o, branche_o, memw_o, memtoreg_o, imme_o, // control bits from the control unit
regw_e, alusrc_e, branche_e, memw_e, memtoreg_e, // control bits to Execution stage
regw_m, memtoreg_m, // control bits to Memory stage
regw_w, memtoreg_w; // control bits to Writeback stage

logic [31:0] pc_adder_mux, // wire adder to PC selector MUX
pc_mux_reg, // wire MUX to PC register
imm_ext_o, // imm wire extended to decode/exe pipe
imm_ext_e; // imm wire in execution stage

logic [31:0] opA_o, opB_o, // operands in point of origin
opA_e, opB_e, // operands in Execution stage
opA_hazard, opB_hazard_imm, opB_hazard, // operands wires between MUXes in Exectuion Stage
alu_result_e, // result data from the ALU in Execution stage
alu_result_w, // result data from the ALU to Writeback stage
read_data_w, // read data from Memory to Writeback stage
result_w; // data selected for writeback in register bank

// %% List of modules per stage %%

// --Fetch--

// PC register
register #(.N(32)) PC (.wen(), .rst(1'b0), .clk(clk), .in(pc_mux_reg), .out(pcf));

// PC adder for next inst address
adder pc_adder (.operandA(pcf), .operandB(32'b100), .result(pc_adder_mux), .cout());

// Mux selector for PC load data
multiplexer pc_load_select (.d1(pc_adder_mux), .d2(), .d3(), .selector(), .out(pc_mux_reg));

// Fetch/Decode instruction pipelined register
fdpipe fetch_decode (.stall_D(), .flush_F(), .clk(clk), .inst_F(inst), .inst_D(inst_fetched));

// --Decode--

// Control unit, only operates in decode stage and is a combinational unit.
control_unit control (.opcode(inst_fetched[31:27]), .ALUControl(alu_control_o), .RegW(regw_o), 
.ALUSrc(alusrc_o), .BranchE(branche_o), .MemW(memw_o), .MemtoReg(memtoreg_o), .ImmE(imme_o));

// Instruction immidiate extender to 32 bits
zeroextend extender (.operand(inst_fetched[18:0]), .result(imm_ext_o));

// Decode/Execution instrucion pipelined register
depipe decode_execution (.flush_E(), .clk(clk),
// input control
.pcload_D(), .regw_D(regw_o), .memw_D(memw_o), .regmem_D(memtoreg_o), .branch_D(branche_o), 
.ALUope_D(alusrc_o), .flag_D(), .ALUctrl_D(alu_control_o),
// input data
.regScr_D(inst_fetched[18:15]), .regA_D(opA_o), .regB_D(opB_o), .inm_D(imm_ext_o),
// output control
.pcload_E(), .regw_E(regw_e), .memw_E(memw_e), .regmem_E(memtoreg_e), .branch_E(branche_e), 
.ALUope_E(alusrc_e), .flag_E(), .ALUctrl_E(alu_control_e),
// output data 
.regScr_E(register_src_e), .regA_E(opA_e), .regB_E(opB_e), .inm_E(imm_ext_e));

// --Execution--

// Operand A selector MUX for hazard unit
multiplexer opA_select (.d1(opA_e), .d2(), .d3(), .selector(2'b0), .out(opA_hazard));

// Operand B selector MUX for hazard unit
multiplexer opB_select (.d1(opB_e), .d2(), .d3(), .selector(2'b0), .out(opB_hazard_imm));

// Operand B selector MUX register or imm
multiplexer opB_select1 (.d1(opB_hazard_imm), .d2(imm_ext_e), .d3(), 
.selector({1'b0,alusrc_e}), .out(opB_hazard));

// ALU
alu alu_unit (.opcode(alu_control_e), // control
.operandA(opA_hazard), .operandB(opB_hazard), .result(alu_result_e), // data
.C_Flag(), .O_Flag(), .N_Flag(), .Z_Flag());

// Execution/Memory instruction pipelined register
empipe execution_memory (.clk(clk),
// input control
.pcload_E(), .regw_E(regw_e), .memw_E(memw_e), .regmem_E(memtoreg_e),
// input data
.regScr_E(register_src_e), .ALUrslt_E(alu_result_e), .address_E(opB_hazard),
// output control
.pcload_M(), .regw_M(regw_m), .memw_M(memw_m), .regmem_M(memtoreg_m),
// output data
.regScr_M(register_src_m), .ALUrslt_M(m_data), .address_M(m_address));

// --Memory--
// This stage has no modules, data memory is outside the processor

// Memory/Writeback instruction pipelined register
mwpipe memory_writeback (.clk(clk),
// input control
.pcload_M(), .regw_M(regw_m), .regmem_M(memtoreg_m),
// input data
.regScr_M(register_src_m), .ALUrslt_M(m_data), .readdata_M(data),
// output control
.pcload_W(), .regw_W(regw_w), .regmem_W(memtoreg_w),
// output data
.regScr_W(register_src_w), .ALUrslt_W(alu_result_w), .readdata_W(read_data_w));

// Selector MUX for memory data result or ALU operation result
multiplexer memory_alu_mux (.d1(alu_result_w), .d2(read_data_w), .d3(), 
.selector({1'b0,memtoreg_w}), .out(result_w));

endmodule 