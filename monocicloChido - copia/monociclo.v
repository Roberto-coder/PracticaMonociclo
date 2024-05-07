/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:			monociclo.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Encapsulamiento para la obtención de la instrucción
*/

module monociclo(
	input					clk_i,
	input					rst_ni,
	output	[31:0]	salida_o
);

	wire 	[31:0]		pc_r;
	wire 	[31:0]		pcnext_w;
	
	PC pc1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.pcnext_i(pcnext_w),
		.pc_o(pc_r)
	);
	
	assign pcnext_w = pc_r + 32'h4;
	
	icache IC(
		.clk_i(clk_i),
		.rdaddr_i(pc_r[7:2]),
		.inst_o(salida_o)
	);
	
	

endmodule
