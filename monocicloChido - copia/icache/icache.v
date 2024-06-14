/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:		icache.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
					Montoya Morales Luis Antonio
					Navarrete Becerril Sharon Anette
					Quintana Romero Roberto
					Urdaneta Villalobos Paul Alejandro

	Descripcion:	Memoria cache para el almacenamiento de instrucciones
*/

module icache(
	input			clk_i,
	input 	[5:0]	rdaddr_i,
	output	[31:0]	inst_o
);

	//Memoria
	reg [31:0]	memoria	[0:63];	//Ancho y despues profundidad
		initial begin
		$readmemh("D:\\ESCOM\\AC\\monociclo\\burbuja.hex", memoria);
	end
	// Lectura de memoria
	assign inst_o = memoria[rdaddr_i];

endmodule
