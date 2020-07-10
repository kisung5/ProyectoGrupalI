// Top module of the RSA ASIP system.
// clk_50mhz of the DE1 SOC FPGA, clock generator for SOC is 50MHz

module rsa_asip_system
(input logic clk, rst,
output [31:0] pc);//, selected,
//output logic h_sync, v_sync, clk_25mhz, sync_n, blank_n,
//output logic [7:0] rgb);

logic m_write_e;
logic [7:0] m_read_data;
logic [31:0] inst, pc_f,
m_write_data, m_address;

// Processor is a ASIP for the RSA algorithm
processor cpu
(.clk(clk), .rst(rst), .inst(inst), // instruction input from inst memory
.input_data({24'b0,m_read_data}), // data input from data memory
.memw_m(m_write_e), // memory write enable output control
.pcf(pc_f), // pc address output to inst memory
.m_address(m_address), // memory address output to data memory
.m_data(m_write_data));

// Data memory, RAM type. 
data_memory ram
(.address(m_address[18:0]), .clock(~clk), .data(m_write_data[7:0]),
.wren(m_write_e), .q(m_read_data));

// Instruction memory, ROM type
Instr_mem rom
(.a(pc_f), .rd(inst));

assign pc = pc_f;
// Single output of the system, VGA controller for a 640x480 display
//VGA_Controller Vga_controller (.clk(clk), .selected(selected), 
//.h_sync(h_sync), .v_sync(v_sync), .rgb(rgb),
//.clk_25mhz(clk_25mhz), .sync_n(sync_n), .blank_n(blank_n));

endmodule 