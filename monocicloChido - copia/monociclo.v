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

	Descripcion:	Monociclo, proceesador de instrucciones R, I, S, L, J y B
*/

module monociclo(
	input					clk_i,
	input					rst_ni,
	output	[31:0]			salida_o
);

	/*	-----------------
	*	Wires section
	*	-----------------	
	*/
	// Fetch Instruction
	wire	[31:0]	if_pc_w;
	wire	[31:0]	if_pcnext_branch_w;
	wire	[31:0]	if_pcnext_sum_w;
	wire	[31:0]	if_pcnext_w;
	wire	[31:0]	if_inst_w;

	// Instruction Decoder
	wire			id_branch_w;
	wire			id_memread_w;
	wire			id_memtoreg_w;
	wire	[2:0]	id_aluop_w;
	wire			id_memwrite_w;
	wire			id_alusrc_w;
	wire			id_regwrite_w;

	// Register File
	wire	[31:0]	rf_rdata1_w;
	wire	[31:0]	rf_rdata2_w;
	wire	[31:0]	rf_immgen_w;

	// Execution
	wire	[4:0]	ex_aluop_w;
	wire	[31:0]	ex_alures_w;
	wire	[31:0]	ex_alusel_w;
	wire	[31:0]	ex_shiftres_w;
	wire	[31:0]	ex_jumpres_w;
	wire			ex_aluzero_w;

	// Memory Access
	wire	[31:0]	mem_rdata_w;

	// Write back
	wire	[31:0] wb_wdata_w;

	/*	-----------------
	*	Instances section
	*	-----------------	
	*/
	// Fetch Instruction
	PC pc1(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.pcnext_i(if_pcnext_w),
		.pc_o(if_pc_w)
	);
	

	assign if_pcnext_sum_w = if_pc_w + 32'h4;
	assign if_pcnext_w = (id_branch_w & ex_aluzero_w) ? if_pcnext_branch_w : if_pcnext_sum_w;
	
	icache IC(
		.rdaddr_i(if_pc_w[7:2]),	// Offset de 2 bits
		.inst_o(if_inst_w)
	);
	
	// Instruction Decoder
	decoder deco(
		.opcode_i(if_inst_w[6:0]),
		.regwrite_o(id_regwrite_w),
		.branch_o(id_branch_w),
		.alusrc_o(id_alusrc_w),
		.memtoreg_o(id_memtoreg_w),
		.memwrite_o(id_memwrite_w),
		.memread_o(id_memread_w),
		.aluop_o(id_aluop_w)
	);
	
	// Register File
	regfile register(
		.clk_i(clk_i),
		.rs1_i(if_inst_w[19:15]),
		.rs2_i(if_inst_w[24:20]),
		.rd_i(if_inst_w[11:7]),
		.we_i(id_regwrite_w),
		.datord_i(wb_wdata_w),
		.dators1_o(rf_rdata1_w),
		.dators2_o(rf_rdata2_w)
	);
	
	signextend sigex(
		.inst_i(if_inst_w),
		.imm_o(rf_immgen_w)
	);

	// Execution
	ALUControl aluctr(
		.opcode_i(id_aluop_w),
		.fun3_i(if_inst_w[14:12]),
		.fun7_i(if_inst_w[30]),
		.aluop_o(ex_aluop_w)
	);

	// ----------Multiplexor segundo operando de la alu
	assign ex_alusel_w = id_alusrc_w ? rf_rdata2_w : rf_immgen_w;
	
	sll1bit sllmod(
		.entrada_i(rf_immgen_w),
		.salida_o(ex_shiftres_w)
	);

	assign if_pcnext_branch_w = ex_shiftres_w + if_pc_w;

	ALUNBits #(
		.N(32)
	) alu
	(
		.a_i(rf_rdata1_w),
		.b_i(ex_alusel_w),
		.c_i(ex_aluop_w[4]),
		.invert_i(ex_aluop_w[4]),
		.operacion_i(ex_aluop_w[3:0]),
		.resultado_o(ex_alures_w),
		.c_o(ex_aluzero_w)
	);

	// Memory
	memory mem(
		.clk_i(clk_i),
		.address_i(ex_alures_w),
		.wdata_i(rf_rdata2_w),
		.memwrite_i(id_memwrite_w),
		.memread_i(id_memread_w),
		.rdata_o(mem_rdata_w)
	);
	
	// Write back
	assign wb_wdata_w = id_memtoreg_w ? mem_rdata_w : ex_alures_w;
	assign salida_o = wb_wdata_w;

endmodule
