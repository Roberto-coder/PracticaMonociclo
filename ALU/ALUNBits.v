/*
	Grupo:			5CV3
	Proyecto:		ALUNBits
	Archivo:			ALUNBits.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Generar ALU de N bits
*/

module ALUNBits #(
	parameter	N = 4
)
(
	input 		[N-1:0] a_i,
	input 		[N-1:0] b_i,
	input 				c_i,
	input 				invert_i,
	input 				less_i,
	input 		[3:0] 	operacion_i,
	output reg	[N-1:0] resultado_o,
	output 				c_o
);

	wire   [N:0]   carries_w;
	wire	 set_o;
	assign carries_w[0] = c_i;
	wire	 [N-1:0] restmp_w;

	//Variable para bucle
	genvar i;
	generate
		for(i = 0; i < N; i = i + 1)
			begin:alubucle
				case(i)
					0:
			
						//Instancia de la ALU de 1 Bit
						ALUbitN ALU1Bit(
							.a_i			(a_i[i]),
							.b_i			(b_i[i]),
							.c_i			(carries_w[i]),
							.invert_i		(invert_i),
							.less_i			(set_o),
							.lessu_i		(~carries_w[N]),
							.operacion_i	(operacion_i),
							.resultado_o	(restmp_w[i]),
							.c_o			(carries_w[i+1])
						);
					
					N-1:
						ALUbitN ALUBitN_1(
							.a_i			(a_i[i]),
							.b_i			(b_i[i]),
							.c_i			(carries_w[i]),
							.invert_i		(invert_i),
							.less_i			(1'b0),
							.lessu_i		(1'b0),
							.operacion_i	(operacion_i),
							.resultado_o	(restmp_w[i]),
							.c_o			(carries_w[i+1]),
							.set_o			(set_o)
						);
						
					default:
						ALUbitN ALUBitX(
							.a_i			(a_i[i]),
							.b_i			(b_i[i]),
							.c_i			(carries_w[i]),
							.invert_i		(invert_i),
							.less_i			(1'b0),
							.lessu_i		(1'b0),
							.operacion_i	(operacion_i),
							.resultado_o	(restmp_w[i]),
							.c_o			(carries_w[i+1])
						);
					
				endcase
			end
	endgenerate
	
	always@(*)
	begin
		case(operacion_i)
			4'b0110: resultado_o = restmp_w >> b_i; 		//SLR
			4'b0111: resultado_o = restmp_w << b_i; 		//SLL
			4'b1000: resultado_o = restmp_w >>> b_i; 		//SRA
			default: resultado_o = restmp_w; 				//Others
		endcase
	end
	
	assign c_o = carries_w[N];
	
	
	
endmodule