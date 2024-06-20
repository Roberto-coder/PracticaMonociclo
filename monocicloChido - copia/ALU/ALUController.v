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
    input       [2:0]   opcode_i,
    input       [2:0]   fun3_i,
    input               fun7_i,
    output reg  [4:0]   aluop_o
);

    always @(*) begin
        case(opcode_i)
            3'b000:         // Operaciones Tipo R
                case (fun3_i)
                    3'b000:                // Suma - Resta
                        if(fun7_i)
                            aluop_o = 5'b10010; // Resta
                        else
                            aluop_o = 5'b00010; // Suma
                    3'b001:                // AND
                        aluop_o = 5'b00000;
                    3'b010:                // OR
                        aluop_o = 5'b00001;
                    3'b011:                // XOR
                        aluop_o = 5'b00100;
                    3'b100:                // SLT
                        aluop_o = 5'b00011;
                    3'b101:                // SLTU
                        aluop_o = 5'b00101;
                    3'b110:                // SLL
                        aluop_o = 5'b00111;
                    3'b111:
                        if(fun7_i)         // SLR
                            aluop_o = 5'b00110;
                        else               // SRA
                            aluop_o = 5'b01000;
                    default:               // Operacion no soportada
                        aluop_o = 5'b00000;
                endcase
            3'b001:         // Operaciones Tipo I
                case (fun3_i)
                    3'b000:                // ADDI
                        aluop_o = 5'b00010;
                    3'b001:                // ANDI
                        aluop_o = 5'b00000;
                    3'b010:                // ORI
                        aluop_o = 5'b00001;
                    3'b011:                // XORI
                        aluop_o = 5'b00100;
                    3'b100:                // SLTI
                        aluop_o = 5'b00011;
                    3'b101:                // SLTUI
                        aluop_o = 5'b00101;
                    3'b110:                // SLLI
                        aluop_o = 5'b00111;
                    3'b111:
                        aluop_o = 5'b00110; // SRLUI
                    default:               // Operacion no soportada
                        aluop_o = 5'b00000;
                endcase
            3'b010:         // Operaciones Tipo S
                aluop_o = 5'b00010; // ADD
            3'b011:         // Operaciones Tipo L
                aluop_o = 5'b00010; // ADD
            3'b100:         // Operaciones Tipo B
                aluop_o = 5'b00010; // ADD
            3'b101:         // Operaciones Tipo J
                aluop_o = 5'b00111; // OR
            default:            // Instruccion no soportada
                aluop_o = 5'b00000;
        endcase
    end

endmodule