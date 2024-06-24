/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:			sll1bit.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Corrimiento logico a la izquierda para las branches
*/
module sll1bit(
    input [31:0] entrada_i,
    output [31:0] salida_o
);

    assign salida_o = entrada_i << 1;

endmodule