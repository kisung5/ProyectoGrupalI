module VGA_Controller_Testbench_Output;

	logic clk = 0;
	logic h_sync;
	logic v_sync;
	logic [7:0] rgb;
	logic clk_25mhz;
	logic sync_n;
	logic blank_n;
	
	logic reset;
	integer file;
	longint i;
	
	VGA_Controller VGA (clk, 1'b0, h_sync, v_sync, rgb, clk_25mhz, sync_n, blank_n);
	
	always #20 clk = ~clk;

	//Clock and reset release
	initial begin
		clk=0; reset=1; //Clock low at time zero
		@(posedge clk);
		@(posedge clk);
		reset=0;
	end
	
	initial begin
		file = $fopen("D:/Drive de Eduardo/Dropbox/Documentos/TEC/SEMESTRE 11 - I 2020/Arquitectura de Computadores I (CE4301)/Proyectos/Proyectos grupales/Proyecto grupal 1/Git/ProyectoGrupalI/VGA/vga_testbench.txt","w");

		@(negedge reset); //Wait for reset to be released
		@(posedge clk);   //Wait for fisrt clock out of reset

		for (i = 0; i<64'd2500000; i=i+1)
		begin
			@(posedge clk);
			//$fwrite(file, "%0d ns: %b %b %b %b %b\n", (20 * i), h_sync, v_sync, rgb[7:5], rgb[4:2], rgb[1:0]);
			$fwrite(file, "%b ", rgb);
		end

		$fclose(file);  

		$finish;
	end
	
endmodule