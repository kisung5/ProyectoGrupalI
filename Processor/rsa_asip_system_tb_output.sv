`timescale 1 ps / 1 ps
module rsa_asip_system_tb_output ();

logic clk, rst, selected, reg15,
h_sync, v_sync, clk_25mhz, sync_n, blank_n;
//logic [31:0] pc;
logic [7:0] rgb;
integer file1, file2;
integer i;

rsa_asip_system DUT
(.clk(clk), .rst(rst), .selected(selected), .reg15(reg15),
//);
.h_sync(h_sync), .v_sync(v_sync), .clk_25mhz(clk_25mhz), .sync_n(sync_n), .blank_n(blank_n),
.rgb(rgb));


always #5 clk = ~clk;
//always #8400000 selected = ~selected;

//Clock and reset release
initial begin
	clk=0; rst=1; //Clock low at time zero
	selected = 0;
	@(posedge clk);
	@(posedge clk);
	rst=0;
end

initial begin
	file1 = $fopen("vga_encrypted.txt","w");
	file2 = $fopen("vga_decrypted.txt","w");

	@(negedge rst); //Wait for reset to be released
	@(posedge clk);   //Wait for fisrt clock out of reset

	for (i = 0; i<840100; i=i+1)
	begin
		@(posedge clk_25mhz);
		$fwrite(file1, "%b %b %b\n", h_sync, v_sync, rgb);
	end
	
	@(posedge clk);
	selected = 1;
	@(posedge clk);
	@(posedge reg15);
	@(posedge clk);
	
	for (i = 0; i<1260150; i=i+1)
	begin
		@(posedge clk_25mhz);
		$fwrite(file2, "%b %b %b\n", h_sync, v_sync, rgb);
	end
	
	$fclose(file1);  
	$fclose(file2);

	$finish;
end

//vsim -gui -l msim_transcript work.rsa_asip_system_tb -L altera_mf_ver -L altera_mf

endmodule 