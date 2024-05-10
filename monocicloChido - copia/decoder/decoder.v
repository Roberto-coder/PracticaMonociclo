module decoder(
	input [6:0]	opcode_i,
	output reg	regwrite_o,
	output reg	alusrc_o
);

	always@(*) begin
		case(opcode_i)
			7'b0010011: begin						// Tipo I
				regwrite_o 	<= 1'b1;
				alusrc_o 	<= 1'b1;
			end
			7'b0110011: begin						// Tipo R
				regwrite_o 	<= 1'b1;
				alusrc_o 	<= 1'b0;
			end
			default: begin							// Instruccion no soportada
				regwrite_o 	<= 1'b0;
				alusrc_o 	<= 1'b0;
			end
		endcase
	end

endmodule 