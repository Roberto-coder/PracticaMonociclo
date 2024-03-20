
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

	Descripcion:	SRL bit por bit
*/

module passthrough(
    input entrada, 	// Entrada de N bits
	 input a_i;			// Bit N de A
	 
    output salida    // Salida del shift
);


always @(*) 
	begin
		salida = a_i; // Enviar el valor de a_i a la salida
		a_i = entrada; // Asignar el valor de la entrada a a_i
		 
	end

endmodule