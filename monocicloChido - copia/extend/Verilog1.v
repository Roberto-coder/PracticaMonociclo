module signextend #(
	parameter 	IMM = 20
)
(
	input 	[31:0] 		inst_i, 	//Instruccion
	output 	[31:0] 		imm_o		//Inmediato
);

	wire [6:0] opcode_w;
	assign opcode_w = inst_i[6:0];

	always @(*) begin
		case(opcode_w)
				7'b0010011: // Tipo I
					imm_o <= {{IMM{inst_i[31]}}, inst_i[31:20]};
				default:
					imm_o <= 32'b0;
		endcase
	endi

endmodule 