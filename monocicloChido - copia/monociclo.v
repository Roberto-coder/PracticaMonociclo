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

	wire 	[31:0]		if_pc_r;
	wire 	[31:0]		if_pcnext_w;
	wire 	[31:0]		rf_inst_w;
	wire	[31:0]		ex_datars1_w;
	wire	[31:0]		ex_datars2_w;
	//wire 					id_regwrite_w;
	//wire	[31:0]		es_data_o;
	//wire 	[31:0]		muxalu_data_w;
	//wire					id_alusrc_w;
	wire 	[31:0]		wb_alurs_w;
	
	// Fetch Instruction
	PC pc1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.pcnext_i(if_pcnext_w),
		.pc_o(if_pc_r)
	);
	
	assign if_pcnext_w = if_pc_r + 32'h4;
	
	icache IC(
		.clk_i(clk_i),
		.rdaddr_i(if_pc_r[7:2]),
		.inst_o(rf_inst_w)
	);
	
	// Register File & Instruction Decoder
	/*decoder deco(
		.opcode_i(if_inst_w[6:0]),
		.regwrite_o(id_regwrite_w),
		.alusrc_o(id_alusrc_w)
	);
	*/
	// Tarea
	regfile register(
		.clk_i(clk_i),
		.rs1_i(rf_inst_w[19:15]),
		.rs2_i(rf_inst_w[24:20]),
		.rd_i(rf_inst_w[11:7]),
		.we_i(1'b1),
		.datord_i(wb_alurs_w),
		.dators1_o(rf_datars1),
		.dators2_o(rf_datars2)
	);
	
	
	/*signextend sigex(
		.inst_i(if_inst_o),
		.imm_o(se_data_o)
	);*/
	
	// Execution & Write Back
	
	// Multiplexor segundo operando de la alu
	//assign muxalu_data_w = id_alu_src ? se_data_o : rf_datars1_o;
	
	ALUNBits #(
		.N(32)
	)
	(
		.a_i(rf_datars1),
		.b_i(rf_datars2),
		.c_i(rf_inst_w[30]),
		.invert_i(rf_inst_w[30]),
		.operacion_i({rf_inst_w[30],rf_inst_w[14:12]}),
		.resultado_o(wb_alurs_w),
		.c_o()
	);
	
	assign salida_o = wb_alurs_w;
	
	//assign wb_resultado_o = ex_resultado_o;

endmodule
