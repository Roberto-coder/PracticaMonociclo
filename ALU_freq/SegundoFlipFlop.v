/*
	Grupo:			5CV3
	Proyecto:		ALU_freq
	Archivo:			RisingEdge_DFlipFlop_SyncReset.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	flip flop D Salidas de la ALU
*/

module SegundoFlipFlop(
	
	input clk_i,
	input async_reset_i, 
	
	input Dc_i, 
	input [31:0] Dsalida_i, 
	input Dbranch_flag_o, 
	
	output reg Qc_o,
	output reg [31:0] Qsalida_o,
	output reg Qbranch_flag_o
);
	
	always @(posedge clk_i,negedge async_reset_i) 
		begin
			 if(async_reset_i == 1'b0) begin
				  Qc_o <= 1'b0;
				  Qsalida_o <= 1'b0;
				  Qbranch_flag_o <= 1'b0;
			 end else begin
				  Qc_o <= Dc_i; 
				  Qsalida_o <= Dsalida_i; 
				  Qbranch_flag_o <= Dbranch_flag_o;
			 end
		end

		
endmodule 