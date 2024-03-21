
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

/*
module ComprobarCarry(
    input wire a_i,
    input wire c_i,
    output reg resultado_o,
    output wire salida_o
);

// La salida salida_o simplemente pasa el valor de a_i
assign salida_o = a_i;

// La lógica para ajustar resultado_o basado en el estado de c_i
always @(*) begin
    if (c_i == 0) begin
        resultado_o = 0; // Si c_i es 0, entonces resultado_o se pone a 0
    end else begin
        resultado_o = 1; // Si c_i es 1, entonces resultado_o se pone a 1
    end
end

//endmodule
*/