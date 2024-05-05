/*
	Grupo:			5CV3
	Proyecto:		ALU
	Archivo:			ALU.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Primera version monocliclo
*/

module monociclo (
	input					clk_i,
	input					rst_ni,
	output		[6:0]	disp0,
	output		[6:0]	disp1,
	output		[6:0]	disp2,
	output		[6:0]	disp3,
	output		[6:0]	disp4,
	output		[6:0]	disp5,
	output		[6:0]	disp6,
	output		[6:0]	disp7
);
	// SECCION DE DECLARACION DE SEÑALES
	reg		[31:0]	pc_r;
	wire		[31:0]	pcnext_w;
	wire 		[31:0]	salida_o;
	reg		[31:0]	cuenta;
	// Seccion de asingacion de señales para monitero en FPGA
	assign	salida_o = pc_r;
	wire		clk_w;
	
	divfreq DivFreq(
		.clk_i (clk_i),
		.rst_ni (rst_ni),
		.clk_o (clk_w)
	);

	// PC
	always @(posedge clk_w, negedge rst_ni) // reset asincrono
	begin
		if (!rst_ni)
			pc_r <= 32'b0;
		else
			pc_r <= pcnext_w;
	end
	
	assign	pcnext_w = pc_r + 32'h4;
	

	
	Disp7segs disp_0(
		.entrada_i	(salida_o[3:0]),
		.monitor_o	(disp0)
	);
	
	Disp7segs disp_1(
		.entrada_i	(salida_o[7:4]),
		.monitor_o	(disp1)
	);
	
	Disp7segs disp_2(
		.entrada_i	(salida_o[11:8]),
		.monitor_o	(disp2)
	);
	
	Disp7segs disp_3(
		.entrada_i	(salida_o[15:12]),
		.monitor_o	(disp3)
	);
	
	Disp7segs disp_4(
		.entrada_i	(salida_o[19:16]),
		.monitor_o	(disp4)
	);
	
	Disp7segs disp_5(
		.entrada_i	(salida_o[23:20]),
		.monitor_o	(disp5)
	);
	
	Disp7segs disp_6(
		.entrada_i	(salida_o[27:24]),
		.monitor_o	(disp6)
	);
	
	Disp7segs disp_7(
		.entrada_i	(salida_o[31:28]),
		.monitor_o	(disp7)
	);
	
	//INSTANCIA DE LA MEMORIA DE INSTRUCCIONES
	icache icache_u0(
		.rdaddr_i,	(pc_r[7:2]),
		.inst_o		(if_inst_o)
	)

endmodule 	