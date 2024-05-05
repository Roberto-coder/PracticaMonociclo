module divfreq (

	input clk_i,
	input rst_ni,
	
	output reg clk_o
);

	//SECCIÓN DE DECLARACIÓN DE SEÑALES
	reg	[31:0]cuenta;

	always @(posedge clk_i, negedge rst_ni)
		begin
			if(!rst_ni)
			begin
				clk_o<=1'b1;
				cuenta<=32'b0;
			end
			else
			begin
				if(cuenta==32'd50_000_000)
				begin
					cuenta<=32'b0;
					clk_o<=~clk_o;
				end
				else
				begin
					cuenta<=cuenta+1'b1;
				end
			end
		end


endmodule