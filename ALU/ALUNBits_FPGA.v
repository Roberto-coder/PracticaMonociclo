/*
	Grupo:			5CV3
	Proyecto:		ALUFPGA
	Archivo:			ALUFPGA.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
						Montoya Morales Luis Antonio
						Navarrete Becerril Sharon Anette
						Quintana Romero Roberto
						Urdaneta Villalobos Paul Alejandro

	Descripcion:	Configurar Display a la ALU
*/


module ALUNBits_FPGA(
	input [2:0] addra_i,
	input [2:0] addrb_i,
	input c_i,
	input invert_i,
	input [3:0] operacion_i,
	input	 [1:0] seloperacion_i,

	output [6:0] disp0_o,
	output [6:0] disp1_o,
	output [6:0] disp2_o,
	output [6:0] disp3_o,
	output [6:0] disp4_o,
	output [6:0] disp5_o,
	output [6:0] disp6_o,
	output [6:0] disp7_o,
	
	output		 c_o
	
);

	//SECCIÓN DE DEFINICIÓN DE SEÑALES
	wire	[31:0] opea_w;//vector A
	wire	[31:0] opeb_w;// vector B
	reg 	[31:0] monitor_o;
	wire 	[31:0] salida_o;// resultado
	
	//Instancia de memorias
	memoria_a mema(
		.addr_i		(addra_i),
		.operador_o	(opea_w)
	);
	
	memoria_b memb(
		.addr_i		(addrb_i),
		.operador_o	(opeb_w)
	);
	
	//Instancia de la ALU N Bits
	ALUNBits #(
		.N	(32)
	)
	
	ALUNBits(
		.a_i				(opea_w),
		.b_i				(opeb_w),
		.c_i				(c_i),
		.invert_i		(invert_i),
		//.less_i			(),
		.operacion_i	(operacion_i),
		.resultado_o	(salida_o),
		.c_o				(c_o)
	);
	
	// Definir el código para SLR en operacion_i
   localparam SLTU_OP = 4'b0101;	// SLTU
	localparam SLR_OP =4'b0111;	//SLR
	localparam SLL_OP =4'b1000;	//SLL
	localparam SRA_OP =4'b1001;	//SRA
	
	
	
	
	//Displays de 7 segmentos
	Disp7segs	Disp0(
	.entrada_i	(monitor_o[3:0]),
	.monitor_o	(disp0_o)
	);
	
	Disp7segs	Disp1(
	.entrada_i	(monitor_o[7:4]),
	.monitor_o	(disp1_o)
	);
	
	Disp7segs	Disp2(
	.entrada_i	(monitor_o[11:8]),
	.monitor_o	(disp2_o)
	);
	
	Disp7segs	Disp3(
	.entrada_i	(monitor_o[15:12]),
	.monitor_o	(disp3_o)
	);
	
	Disp7segs	Disp4(
	.entrada_i	(monitor_o[19:16]),
	.monitor_o	(disp4_o)
	);
	
	Disp7segs	Disp5(
	.entrada_i	(monitor_o[23:20]),
	.monitor_o	(disp5_o)
	);

	Disp7segs	Disp6(
	.entrada_i	(monitor_o[27:24]),
	.monitor_o	(disp6_o)
	);
	
	Disp7segs	Disp7(
	.entrada_i	(monitor_o[31:28]),
	.monitor_o	(disp7_o)
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

        case (operacion_i)
            SLR_OP: 
				begin
                monitor_o = opea_w >> opeb_w;//SLR
            end
				SLL_OP: 
				begin
                monitor_o = opea_w << opeb_w;//SLR
            end 
				
				SRA_OP: 
				begin
                monitor_o = $signed(opea_w) >>> opeb_w;//SLR
            end
				SLTU_OP: 
					monitor_o = $unsigned(opea_w) < $unsigned(opeb_w);//SLTU
            
            default: monitor_o = {32'b0}; // Valor por defecto
        endcase
		end
	
endmodule