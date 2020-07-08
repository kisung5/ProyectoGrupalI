module VGA_Controller (
	input logic clk,
	input logic selected,
	output logic h_sync,
	output logic v_sync,
	output logic [7:0] rgb,
	output logic clk_25mhz,
	output logic sync_n,
	output logic blank_n
	);
	
	// VGA Control ariables
	logic enable_v_counter;
	logic [15:0] h_count_value;
	logic [15:0] v_count_value;
	
	// Images variables
	logic [7:0] current_pixel_encrypted;
	logic [7:0] current_pixel_decrypted;
	logic [20:0] address;
	
	// Clock divider
	Clock_Divider vga_clock_gen (clk, clk_25mhz);
	
	// Counters
	Horizontal_Counter vga_horizontal (clk_25mhz, enable_v_counter, h_count_value);
	Vertical_Counter vga_vertical (clk_25mhz, enable_v_counter, v_count_value);
	
	// Based on VGA standards
	assign h_sync = (h_count_value < 96) ? 1'b1:1'b0;
	assign v_sync = (v_count_value < 2) ? 1'b1:1'b0;
	
	// Decrypted image file
	Sram #(20, 8, 310000, "D:/Drive de Eduardo/Dropbox/Documentos/TEC/SEMESTRE 11 - I 2020/Arquitectura de Computadores I (CE4301)/Proyectos/Proyectos grupales/Proyecto grupal 1/Git/ProyectoGrupalI/VGA/decrypted.mem")
	decrypted(clk, address, 0, 16'b0, current_pixel_decrypted);
	
	// Encrypted image file
	Sram #(20, 8, 310000, "D:/Drive de Eduardo/Dropbox/Documentos/TEC/SEMESTRE 11 - I 2020/Arquitectura de Computadores I (CE4301)/Proyectos/Proyectos grupales/Proyecto grupal 1/Git/ProyectoGrupalI/VGA/encrypted.mem")
	encrypted(clk, address, 0, 16'b0, current_pixel_encrypted);
	
	// Black color
	assign black = 8'h0;
	

	always @*
	begin		
		// If the selected image is decrypted
		if(selected == 1'b0)
		begin
			// If the horizontal and vertical counters are in the display area and image area
			if(h_count_value >= 144 && h_count_value < 464 && v_count_value >= 35 && v_count_value < 515)
			begin
				address = (h_count_value - 144)*480 + v_count_value - 35;
				// Sacalar color quantization
				rgb[7:5] = current_pixel_decrypted[7:5];
				rgb[4:2] = current_pixel_decrypted[7:5];
				rgb[1:0] = current_pixel_decrypted[7:6];
			end
			else
			begin
				address = 0;
				rgb = 8'b0;
			end
		end
		// Any other case
		else
		begin
			address = 0;
			rgb = 8'b0;
		end
	end

	// Based on VGA standards
	assign sync_n = 1'b0;
	assign blank_n = 1'b1;
	
endmodule