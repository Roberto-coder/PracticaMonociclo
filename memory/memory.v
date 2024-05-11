/*
	Grupo:			5CV3
	Proyecto:		Memoria
	Archivo:		memory.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
                    Montoya Morales Luis Antonio
                    Navarrete Becerril Sharon Anette
                    Quintana Romero Roberto
                    Urdaneta Villalobos Paul Alejandro

	Descripcion:	Meoria de datos
*/
module memory(
    input                   clk_i,
    input [31:0]            address_i,
    input [31:0]            wdata_i,
    input                   memwrite_i,
    input                   memread_i,
    output reg [31:0]       rdata_o
);

    reg [52_413:0] memoria [31:0];

    always @(posedge clk_i) begin
        if(memwrite_i)
            memoria[address_i] <= wdata_i;
        else if(memread_i)
            rdata_o <= memoria[address_i];
    end

endmodule