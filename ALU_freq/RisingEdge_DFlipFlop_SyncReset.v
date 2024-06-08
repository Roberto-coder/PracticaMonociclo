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

	Descripcion:	flip flop D entradas de la ALU
*/

module PrimerFlipFlop(
	
	input clk_i,
	input async_reset_i, 
	
	input [31:0] Da_i, 
	input [31:0] Db_i, 
	input Dc_i,
	input [2:0] Doperacion_i, 
	input Dinvert_i, 
	
	output reg [31:0] Qa_o, 
	output reg [31:0] Qb_o, 
	output reg Qc_o,
	output reg [2:0] Qoperacion_o,
	output reg Qinvert_o
);
	
	always @(posedge clk_i,negedge async_reset_i) 
		begin
			 if(async_reset_i == 1'b0) begin
				  Qa_o <= 1'b0; 
				  Qb_o <= 1'b0;
				  Qc_o <= 1'b0;
				  Qoperacion_o <= 1'b0;
				  Qinvert_o <= 1'b0;
			 end else begin
				  Qa_o <= Da_i; 
				  Qb_o <= Db_i; 
				  Qc_o <= Dc_i; 
				  Qoperacion_o <= Doperacion_i; 
				  Qinvert_o <= Dinvert_i; 
			 end
		end

		
endmodule 


