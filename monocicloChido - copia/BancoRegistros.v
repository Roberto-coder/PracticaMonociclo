//Encabezados
module BancoRegistros(
	//Puerto de escritura
	input clk_i,
	input	[4:0]		rd_i,
	input [31:0] datard_i,
	input wren_i,
	//Puerto de escritura
	input [4:0]		rs_i,
	output [31:0]	datars1_o,
	input [4:0]		rs2_i,
	output [31:0]	datars2_o
);//sincronos

	//Definir una memoria de 32*32
	reg	[31:0] Registros [0:31];
	
	//Puerto de escritura
	always @(posedge clk_i)
	begin
		if(wren_i)
			Registros[rd_i] = datard_i;
	end
	
	assign datars1_o = Registros[rs1_i];
	assign datars2_o = Registros[rs2_i];
	

endmodule




