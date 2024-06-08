/*
	Grupo:			5CV3
	Proyecto:		ALU_freq
	Archivo:			ALU_freq.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	ALU junto con los flip flops para testear su velocidad de frecuencia
*/


module ALU_freq (
	input [2:0] addra_i,
	input [2:0] addrb_i,
	input c_i,
	input invert_i,
	input [2:0] operacion_i,
	input	 [1:0] seloperacion_i,
	
	input clk_i,
	input async_reset_i,
	
	output	c_o,
	output	ex_zeroflag_o
	
);

	//SECCIÓN DE DEFINICIÓN DE SEÑALES
	wire	[31:0] opea_w;
	wire	[31:0] opeb_w;
	reg 	[31:0] monitor_o;
	wire 	[31:0] salida_o;
	
	//Salidas Primer FLIP FLOP
	wire	[31:0] Qopea_w;
	wire	[31:0] Qopeb_w;
	wire 	Qc_i;
	wire 	Qinvert_i;
	wire 	[2:0] Qoperacion_i;
	
	//Salidas Segundo FlipFlop
	wire 	Qc_o;
	wire 	[2:0] Qsalida_o;
	wire 	Qbranch_flag_o;
	
	//Instancia de memorias
	memoria_a mema(
		.addr_i		(addra_i),
		.operador_o	(opea_w)
	);
	
	memoria_b memb(
		.addr_i		(addrb_i),
		.operador_o	(opeb_w)
	);
	
	PrimerFlipFlop FFin(
		.clk_i(clk_i),
		.async_reset_i(async_reset_i), 

		.Da_i(opea_w), 
		.Db_i(opeb_w), 
		.Dc_i(c_i),
		.Doperacion_i(operacion_i), 
		.Dinvert_i(invert_i), 

		.Qa_o(Qopea_w), 
		.Qb_o(Qopeb_w), 
		.Qc_o(Qc_i),
		.Qoperacion_o(Qoperacion_i),
		.Qinvert_o(Qinvert_i)
	);
	
	//Instancia de la ALU N Bits
	ALUNBits #(
		.N	(32)
	)
	
	ALUNBits(
		.a_i				(Qopea_w),
		.b_i				(Qopeb_w),
		.c_i				(Qc_i),
		.invert_i		(Qinvert_i),
		//.less_i			(),
		.operacion_i	(Qoperacion_i),
		.resultado_o	(salida_o),
		.c_o				(c_o),
		.zeroflag_o		(ex_zeroflag_o)
	);

	always @(*)
	begin
		case (seloperacion_i)
			2'b00:
				monitor_o = salida_o;
			2'b01:
				monitor_o = opea_w;
			2'b10:
				if (invert_i)
					monitor_o	= ~opeb_w;
				else
					monitor_o	= opeb_w;
			default:
				monitor_o = 32'b0;
		endcase
	end
	
	SegundoFlipFlop FFout(	
		.clk_i(clk_i),
		.async_reset_i(async_reset_i),
		
		.Dc_i(c_o), 
		.Dsalida_i(salida_o), 
		.Dbranch_flag_o(ex_zeroflag_o), 
		
		.Qc_o(Qc_o),
		.Qsalida_o(Qsalida_o),
		.Qbranch_flag_o(Qbranch_flag_o)
	);
	
	
	
endmodule
