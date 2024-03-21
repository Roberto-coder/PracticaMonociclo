
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

module shift_8bit
(
	input clk,
	input [7:0] in,
	output reg [7:0] out
);

	integer i;
	reg [7:0] temp;
	always@(posedge clk)
	begin
		temp[7:0] = in[7:0];
		
		for( i = 0; i < 7; i = i+1)
		begin
			out[i+1] <= temp[i];
		end
		out[0] <= temp[7];
	end

endmodule