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

	Descripcion:	Primera version de la ALU (1 bit)
*/
 
 module ALUbitN(
	input a_i,
	input b_i,
	input c_i,
	input invert_i,
	input less_i,
	input [3:0] operacion_i,
	
	output reg resultado_o,
	output c_o,
	output set_o
 );
 
	//Seccion de definicion de Señales
	wire ab1_w; //Salida de la AND
	wire ab2_w; //Salida de la OR
	wire ab3_w; //Salida de la XOR
	wire nob_w;//Salida de la NOT B
	wire selb_w;//Salida de la Inversor B
	wire salidasum_w;//Salida del sumador
	
	//AND GATE
	assign ab1_w = a_i & selb_w;
	
	//OR GATE
	assign ab2_w = a_i | selb_w;
	
	//XOR GATE
	assign ab3_w = a_i ^ selb_w;
	
	//Sumador Restador
	assign nob_w = ~b_i;
	assign selb_w = (invert_i) ? nob_w : b_i;
	

	
	//Instancia sumador
	Fulladder falbit(
		.a_i		(a_i),
		.b_i		(selb_w),
		.c_i		(c_i),
		.c_o		(c_o),
		.s_o		(salidasum_w)
	
	);
	
		/*Instancia SLR
	ShifLogicR slr(
		.entrada	(valor_anterior),
	   .a_i		(a_i),
      .salida	(salida_shift)
	
	);*/
	
	
	assign set_o=salidasum_w;
	
	
	//SELECTOR 3 - 1 (3 entradas, 1 salida)
	//assign resultado_o = (operacion_i) ? ab2_w : ab1_w;
	always@(*)
	begin
		case(operacion_i)
			4'b0000: resultado_o = ab1_w; //AND
			4'b0001: resultado_o = ab2_w; //OR
			4'b0010: resultado_o = salidasum_w; //Suma-Resta
			4'b0011: resultado_o = less_i; //SLT	resultado_o = set_o/c_o;	
			4'b0100: resultado_o = ab3_w;  //XOR
			/*4'b0101: resultado_o = 1'b0;   //SLTU
			4'b0111: resultado_o = 1'b0; //SLR
			4'b1000: resultado_o = 1'b0; //SLL
			4'b1001: resultado_o = 1'b0; //SRA*/
			default: resultado_o = 1'b0; 
		endcase

	end
	
 endmodule