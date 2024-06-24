/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:			signextend.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Modulo que recopila el inmediato y le extiende el signo
*/

module signextend #(
	parameter 	IMM = 20
)
(
	input 		[31:0] 		inst_i, 	//Instruccion
	output reg 	[31:0] 		imm_o		//Inmediato
);

	wire [6:0] opcode_w;
	assign opcode_w = inst_i[6:0];

	always @(*)
	begin
		case (inst_i[6:0])						//OPCODE
			//Tipo I
			7'b0010011:
							imm_o	=	{{IMM{inst_i[31]}},inst_i[31:20]};
			//Tipo S
			7'b0100011:			 		
							imm_o	=	{{IMM{inst_i[31]}},{inst_i[31:25],inst_i[11:7]}};
			//Tipo L
			7'b0000011:			 		
							imm_o	=	{{IMM{inst_i[31]}},inst_i[31:20]};
			//Tipo B
			7'b1100011:			 		
							imm_o	=	{{IMM{inst_i[31]}},{inst_i[31],inst_i[7],inst_i[30:25],inst_i[11:8]}};
			//Tipo J
			7'b1101111:			 		
							imm_o	=	{{12{inst_i[31]}},{inst_i[31],inst_i[19:12],inst_i[20],inst_i[30:21]}};
			default: 
							imm_o	=	{32{1'b0}};
		endcase	
	end


endmodule 