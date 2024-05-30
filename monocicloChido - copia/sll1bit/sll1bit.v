//Encabezado

module sll1bit(
	input		[31:0] entrada_i,		
	output	[31:0] salida_o		


);

assign salida_o = entrada_i <<1;

endmodule


