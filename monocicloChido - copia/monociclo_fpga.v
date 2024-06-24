/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:			monociclo_fpga.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Implementación para verificar el funcionamiento de las diferentes etapas en la FPGA
*/

module monociclo_fpga(
	input clk_i,
	input rst_ni,
	output [6:0] disp0,
	output [6:0] disp1,
	output [6:0] disp2,
	output [6:0] disp3,
	output [6:0] disp4,
	output [6:0] disp5,
	output [6:0] disp6,
	output [6:0] disp7
);

	wire clk_w;
	wire [31:0]	salida_w;

	div_freq divfreq(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.clk_o(clk_w)
	);

	monociclo mono(
		.clk_i(clk_w),
		.rst_ni(rst_ni),
		.salida_o(salida_w)
	);
	
	Disp7segs disp_0(
		.entrada_i	(salida_w[3:0]),
		.monitor_o	(disp0)
	);
	
	Disp7segs disp_1(
		.entrada_i	(salida_w[7:4]),
		.monitor_o	(disp1)
	);
	
	Disp7segs disp_2(
		.entrada_i	(salida_w[11:8]),
		.monitor_o	(disp2)
	);
	
	Disp7segs disp_3(
		.entrada_i	(salida_w[15:12]),
		.monitor_o	(disp3)
	);
	
	Disp7segs disp_4(
		.entrada_i	(salida_w[19:16]),
		.monitor_o	(disp4)
	);
	
	Disp7segs disp_5(
		.entrada_i	(salida_w[23:20]),
		.monitor_o	(disp5)
	);
	
	Disp7segs disp_6(
		.entrada_i	(salida_w[27:24]),
		.monitor_o	(disp6)
	);
	
	Disp7segs disp_7(
		.entrada_i	(salida_w[31:28]),
		.monitor_o	(disp7)
	);

endmodule 