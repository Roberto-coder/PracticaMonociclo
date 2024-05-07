/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:			PC.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Implementación para verificar el funcionamiento de la etapa de Instruction Fetch en la FPGA
*/
module PC(
	input 					clk_i,
	input 					rst_ni,
	input 		[31:0]	pcnext_i,
	output reg	[31:0]	pc_o
);

	always @(posedge clk_i, negedge rst_ni)
	begin
		if(!rst_ni)
			pc_o <= 32'b0;
		else
			pc_o <= pcnext_i;
	end
	
endmodule 