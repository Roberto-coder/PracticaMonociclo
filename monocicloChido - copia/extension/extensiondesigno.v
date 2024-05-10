//Encabezado

module extensiondesigno #(
	parameter 				IMM = 20 //Porque los inmediatos son de 12 bits, y requerimos que sea de 32 para la ALU
)

(
	input				[31:0] instruccion_i,
	output			[31:0] inmediato
);
	wire				[6:0]	opcode_w;
	assign					opcode_w = instruccion_i[6:0];
	
	always @(*)
	begin
		case (opcode_w)
			7'b0010011:		//Tipo I
							inmediato_o = {{IMM{instrucción_i[31]}}, instruccion_i[31:20]} //Replicamos 20 veces el bit de signo y lo concatenamos al inmediato (12 bits), resultando en un inmediato de 32 bits
			default:			//Tipo R
							inmediato_o = 32'b0;
		endcase
	end


endmodule

