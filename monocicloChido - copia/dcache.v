//Encabezado
module dcache(
	input					clk_i,
	input			[5:0] addr_i,
	input			[31:0] dato_i,
	input					memwrite_i,
	input					memread_i,
	output		[31:0] dato_o
);

		//data cache
		reg		[31:0] memoria [0:63];
		
//puerto de escritura syncrono
//puerto de lectura asyncrono

	//puerto de escritura 
	always @(posedge clk_i)
		begin
			if(memwrite_i)
				memoria[addr_i] <= dato_i;
		end

	//Puerto de lectura
	assign dato_o = (memread_i) ? memoria[addr_i] : 32'b0

endmodule