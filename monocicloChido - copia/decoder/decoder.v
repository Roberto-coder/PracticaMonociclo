/*
	Grupo:			5CV3
	Proyecto:		Decoder
	Archivo:		decoder.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
					Montoya Morales Luis Antonio
					Navarrete Becerril Sharon Anette
					Quintana Romero Roberto
					Urdaneta Villalobos Paul Alejandro

	Descripcion:	Decodificador de instrucciones para el control de la ALU, memoria de datos y banco de registros
*/

module decoder(
	input 		[6:0]	opcode_i,
	output reg	[2:0] 	ALUOp_o,
	output reg			branch_o,
	output reg			regwrite_o,
	output reg			alusrc_o,		// Si es uno se toma el inmediato, si es cero se toma el dato del banco de registros
	output reg 			memtoreg_o,
	output reg 			memwrite_o,
	output reg 			memread_o
);

	always@(*) begin
		case(opcode_i)
			7'b0010011: begin						// Tipo I
			// Escribe en banco de registros y recibe inmediato (extension de signo), no utiliza memoria
				regwrite_o 	<= 1'b1;
				alusrc_o 	<= 1'b1;
				branch_o	<= 1'b0;
				memread_o 	<= 1'b0;
				memwrite_o 	<= 1'b0;
				memtoreg_o 	<= 1'b0;
			end
			7'b0110011: begin						// Tipo R
			// Escribe en banco de registros y recibe dato desde el banco de registro, no utiliza memoria
				regwrite_o 	<= 1'b1;
				alusrc_o 	<= 1'b0;
				branch_o	<= 1'b0;
				memread_o 	<= 1'b0;
				memwrite_o 	<= 1'b0;
				memtoreg_o 	<= 1'b0;
			end
			7'b0100011: begin						// Tipo S
			// Guarda dato en memoria, no escribe en banco de registros
				regwrite_o 	<= 1'b0;
				alusrc_o 	<= 1'b1;
				branch_o	<= 1'b0;
				memread_o 	<= 1'b0;
				memwrite_o 	<= 1'b1;
				memtoreg_o 	<= 1'b0;
			end
			7'b0000011: begin						// Tipo L
			//Guarda dato en banco de registros, recibe dato desde memoria
				regwrite_o 	<= 1'b1;
				alusrc_o 	<= 1'b1;
				branch_o	<= 1'b0;
				memread_o 	<= 1'b1;
				memwrite_o 	<= 1'b0;
				memtoreg_o 	<= 1'b1;
			end
			7'b1100011: begin						// Tipo B
			// No escribe en banco de registros, no utiliza memoria
				regwrite_o 	<= 1'b0;
				alusrc_o 	<= 1'b0;
				branch_o	<= 1'b1;
				memread_o 	<= 1'b0;
				memwrite_o 	<= 1'b0;
				memtoreg_o 	<= 1'b0;
			end
			7'b1100111: begin						// Tipo J
				regwrite_o 	<= 1'b0;
				alusrc_o 	<= 1'b0;
				branch_o	<= 1'b1;
				memread_o 	<= 1'b0;
				memwrite_o 	<= 1'b0;
				memtoreg_o 	<= 1'b0;
			end
			default: begin							// Instruccion no soportada
				regwrite_o 	<= 1'b0;
				alusrc_o 	<= 1'b0;
				branch_o	<= 1'b0;
				memread_o 	<= 1'b0;
				memwrite_o 	<= 1'b0;
				memtoreg_o 	<= 1'b0;
			end
		endcase
	end

endmodule 