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
module memory #(
    depth = 64,
    address_length = 6
)(
    input                                   clk_i,
    input [address_length-1:0]              address_i,
    input [31:0]                            wdata_i,
    input                                   memwrite_i,
    input                                   memread_i,
    output [31:0]                       rdata_o
);

    reg [depth-1:0] memoria [31:0];

    always @(posedge clk_i) begin
        if(memwrite_i)
            memoria[address_i] <= wdata_i;
    end
    assign rdata_o = (memread_i) ? memoria[address_i] : 32'b0;

endmodule