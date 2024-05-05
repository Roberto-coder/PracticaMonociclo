/*
Encabezado
*/

module icache(
	input clk_i,
	//puerto de lectura
	input [5:0] rdaddr_i,
	output [31:0] inst_o
);

	//definir la memoria
	reg [31:0][memoria[0:63]];
	
	initial
	begin
		memoria[0]='b00000000;
		memoria[1]='b00000000;
		memoria[2]='b00000000;
	end
	
	//Definir la lectura de la memoria
	assign	inst_o = memoria[rdaddr_i];

endmodule