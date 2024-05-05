/*
	Grupo:			5CV3
	Proyecto:		Display de 7 segmentos
	Archivo:			Disp7segs.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Primera version de la ALU (1 bit)
*/

module Disp7segs	(
	input [3:0] entrada_i,
	output reg [6:0] monitor_o
);

	always @(*)
	begin
		case (entrada_i)
		4'b0000:		 	//gfedcba
			monitor_o=7'b1000000;//0
		4'b0001:
			monitor_o=7'b1111001;//1
		4'b0010:
			monitor_o=7'b0100100;//2
		4'b0011:
			monitor_o=7'b0110000;//3
		4'b0100:
			monitor_o=7'b0011001;//4
		4'b0101:
			monitor_o=7'b0010010;//5
		4'b0110:
			monitor_o=7'b0000010;//6
		4'b0111:
			monitor_o=7'b0111000;//7
		4'b1000:
			monitor_o=7'b0000000;//8
		4'b1001:
			monitor_o=7'b0011000;//9
		4'b1010:
			monitor_o=7'b0001000;//A
		4'b1011:
			monitor_o=7'b0000011;//B
		4'b1100:
			monitor_o=7'b1000110;//C
		4'b1101:
			monitor_o=7'b0100001;//D
		4'b1110:
			monitor_o=7'b0000110;//E
		4'b1111:
			monitor_o=7'b0001110;//F
		endcase
	end

endmodule
