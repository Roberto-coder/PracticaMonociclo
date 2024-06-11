module FlagDetector(
    input id_branch_i,
    input [2:0] f3,
    input resultado_o,
    output branch_flag_o,
)
/*
    beq sub
    bne sub
    blt slt
    bge ~slt
*/
    always @(*) begin
        if(id_branch_i) begin
            case (f3)
                3'b0: branch_flag_o = ~(|resultado_o);
                3'b1: branch_flag_o = (|resultado);
            endcase
        end
    end

endmodule