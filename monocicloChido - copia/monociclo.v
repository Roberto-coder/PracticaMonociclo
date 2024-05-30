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
	wire 					c_o;
	wire 		[31:0] 	es_dato_o;
	wire 		[31:0] 	muxalu_dato_o;
	wire					idregwrite_o;
	wire					id_alusrc_o;
	wire		[31:0]	ssl1bit_o;
	wire		[31:0]	branch_pc_w;
	wire 		[31:0]	id_branch_o;
	wire 		[31:0]	ssldato_o;
	wire 					ex_zeroflag_o;
	wire					pcsrc_w;
	wire		[31:0]	pcbranchnext_W;
	
	// Seccion de asingacion de señales para monitero en FPGA
	assign	salida_o = wb_resultado_o;
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
	
	assign	pcnext_w = pcbranch_W;
	

	
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
	
	//Etapa de decodificacion
	decodificador decode_u0(
		.opcode_i			(if_inst_o),
		.regwrite_o			(idregwrite_o),
		.alusrc_o			(id_alusrc_o),
		.branch_0			(id_branch_o)
	)
	
	//Conectar el banco de registros
		//rf_datos2_o
	BancoRegistros(
	.clk_i		(),
	.rd_i			(),
	.datard_i	(),
	.wren_i		(),
	.rs_i			(),
	.datars1_o	(rf_datos2_o),
	.rs2_i		(),
	.datars2_o	()
	
	//Extensión de signo
	extensiondesigno extend_u3 (
		.instruccion_i			(if_inst_o),
		.inmediato_o			(es_dato_o) //Extension de signo: es_(...)
	);
	
	sll1bit sll1Bit1(
	.entrada_i	(es_dato_o),
	.salida_o	(slldato_o)	


);
	
	//Multiplexor para el segundo operando de la ALU
	assign muxalu_dato_o = (id_alusrc_o) ? esdato_o : rfdators2_o;//FALTA OPCION
	
	//Conectar la alu
	ALUNBits #(
		.N					(32)
	)
	(
		.a_i				(rf_datos2_o),
		.b_i				(muxalu_dato_o),
		.c_i				(if_inst_o[30]),
		.invert_i		(if_inst_o[30]),
		//.less_i			(),
		.operacion_i	({if_inst_o[30],if_inst_o[14:12]}),
		.resultado_o	(ex_resultado_o),
		.c_o				(c_o),
		.zero_flag_o	(ex_zeroflag_o)
	);
	//Sumador para calcular el pc de salto
	assign branch_pc_w = ssl_dato_o + pc_r;
	assign pcsrc_w = id_branch_o & ex_zeroflag_o;
	assign pcbranchnext_w =  (pcsrc_o) ? branchpc_w : pc_next;
	
	
	//Se toma el bit5 de func7 para el bit faltante de la operacion(bit30)

endmodule 	