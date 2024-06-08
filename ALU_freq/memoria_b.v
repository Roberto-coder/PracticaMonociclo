/*
	Grupo:			5CV3
	Proyecto:		ALU_freq
	Archivo:			Disp7segs.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Primera version de la ALU (1 bit)
*/

module memoria_b (
	input 	[2:0] addr_i,
	output 	[31:0] operador_o
);

	//definición de la memoria
	reg [31:0] memory [2**3-1:0];
	
	initial
	begin
		/*memory [0] = 32'b11; //Equipo 5
		memory [1] = 32'b000010000100110010110111100001001; //Equipo 
		memory [2] = 32'b10100111001001100100101001000101; //Equipo */
		memory [0] = 32'b1111_1111_0000_0000_1111_1111_0000_0000;
		memory [1] = 32'b0011_0101_0000_1111_0110_1001_1001_0011;
		memory [2] = 32'h8000_0000;
		memory [3] = 32'h0;
		memory [4] = 32'h1;
		memory [5] = 32'h8;
		memory [6] = 32'd31;
	end
	
	//Puerto de lectura
	assign operador_o = memory[addr_i];
	
endmodule