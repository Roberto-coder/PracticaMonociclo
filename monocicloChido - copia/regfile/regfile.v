/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:			regfile.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Banco de registros
*/

module regfile(
	input				clk_i,		//CLock
	input [0:4]		rs1_i,		// Read register address 1
	input [0:4]		rs2_i,		// Read register address 2
	input [0:4]		rd_i,			// Write register address
	input				we_i,			// Write enable
	input [31:0]	datord_i,	// Write data
	output[31:0]	dators1_o,	//	Read data 1
	output[31:0]	dators2_o	//	Read data 2
);

	reg [31:0] memoria [0:31];

	
	assign dators1_o = memoria[rs1_i];
	assign dators2_o = memoria[rs2_i];
	
	
	always@(posedge clk_i)
	begin
		if(we_i)
			memoria[rd_i] <= datord_i;
	end

endmodule 