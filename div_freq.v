/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:			div_freq.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Divisor de frecuencias a 1Hz
*/
module div_freq(
	input clk_i,
	input rst_ni,
	output reg clk_o
);

	reg [31:0] cuenta_r;

	always @(posedge clk_i, negedge rst_ni) begin
		if(!rst_ni) begin
			clk_o <= 1'b1;
			cuenta_r <= 32'b0;
		end
		else begin
			if(cuenta_r == 32'd50_000_000) begin
					cuenta_r <= 32'd0;
					clk_o <= ~clk_o;
			end
			else begin
				cuenta_r <= cuenta_r + 1'b1;
			end
		end
	end
	
endmodule 