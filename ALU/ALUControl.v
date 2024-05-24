/*
	Grupo:			5CV3
	Proyecto:		Monociclo
	Archivo:		ALUControl.v
	Equipo:			Equipo 2
	Integrantes:	Alcaraz Cuevas Victor Hugo
					Montoya Morales Luis Antonio
					Navarrete Becerril Sharon Anette
					Quintana Romero Roberto
					Urdaneta Villalobos Paul Alejandro

	Descripcion:	Control de las instrucciones de la ALU, traduce operaciones estandar ASM a implementacion de la ALU
*/

module ALUControl (
    input       [6:0]   opcode_i,
    input       [2:0]   fun3_i,
    input               fun7_i,
    output reg  [3:0]   aluop_o
);

    always @(*) begin
        if( opcode_i == 7'b0110011) begin
        // Operaciones Tipo R
            case (fun3_i)
                3'b000:                // Suma - Resta
                    aluop_o = 4'b0010;
                3'b001:                // AND
                    aluop_o = 4'b0000;
                3'b010:                // OR
                    aluop_o = 4'b0001;
                3'b011:                // XOR
                    aluop_o = 4'b0100;
                3'b100:                // SLT
                    aluop_o = 4'b0011;
                3'b101:                // SLTU
                    aluop_o = 4'b0101;
                3'b110:                // SLL
                    aluop_o = 4'b0111;
                3'b111:
                    if(fun7_i)         // SLR
                        aluop_o = 4'b0110;
                    else               // SRA
                        aluop_o = 4'b1000;
                default:               // Operacion no soportada
                    aluop_o = 4'b0000;
            endcase
        end else if (opcode_i == 7'b0010011) begin
        // Operaciones Tipo I
            case (fun3_i)
                3'b000:                // ADDI
                    aluop_o = 4'b0010;
                3'b001:                // ANDI
                    aluop_o = 4'b0000;
                3'b010:                // ORI
                    aluop_o = 4'b0001;
                3'b011:                // XORI
                    aluop_o = 4'b0100;
                3'b100:                // SLTI
                    aluop_o = 4'b0011;
                3'b101:                // SLTUI
                    aluop_o = 4'b0101;
                3'b110:                // SLLI
                    aluop_o = 4'b0111;
                3'b111:
                    aluop_o = 4'b0110; // SRLUI
                default:               // Operacion no soportada
                    aluop_o = 4'b0000;
            endcase
        end else begin
        // Operaciones Tipo S y L hacen solo suma
            aluop_o = 4'b0010;
        end      
    end

endmodule