module regfile(
	input				clk_i,
	input [0:5]		rs1_i,
	input [0:5]		rs2_i,
	input [0:5]		rd_i,
	input				we_i,
	input [31:0]	datord_i,
	output[31:0]	dators1_o,
	output[31:0]	dators2_o
);

	reg [31:0] memoria [0:31];
	
	initial begin
		$readmemh("D:\ESCOM\burbuja.hex", memoria);
	end
	
	assign dators1_o = memoria[rs1_i];
	assign dators2_o = memoria[rs2_i];
	
	
	always@(posedge clk_i)
	begin
		if(we_i)
			memoria[rd_i] <= datord_i;
	end

endmodule 