//Encabezado

module decodificador(
	input		[6:0] opcode_i,
	output reg		regwrite_o,
	output reg		alusrc_o
);

	always @(*)
	begin
		case (opcode_i)
			7'b0010011:		//Tipo I
				begin
					regwrite_o = 1'b1;
					alusrc_o = 1'b1;
				end
			7'b0110011:		//Tipo R
				begin
					regwrite_o = 1'b1;
					alusrc_o = 1'b0;
				end
			default: 		//Instrucción no soportada
				begin
					regwrite_o = 1'b0;
					alusrc_o = 1'b0;
				end
		endcase
	end

endmodule