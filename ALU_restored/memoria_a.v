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

module memoria_a (
	input 	[2:0] addr_i,
	output 	[31:0] operador_o
);

	//definición de la memoria
	reg [31:0] memory [2**3-1:0];
	
	initial
	begin
		/*memory [0] = 32'b11;
		memory [1] = 32'b000010000100110010110111100001001;
		memory [2] = 32'b10100111001001100100101001000101;*/
		memory [0] = 32'b0011_0101_0000_1111_0110_1001_1001_0010;
		memory [1] = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
		memory [2] = 32'h8000_0000;

	end
	
	//Puerto de lectura
	assign operador_o = memory[addr_i];
	
endmodule