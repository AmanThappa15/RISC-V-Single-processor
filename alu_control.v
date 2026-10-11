
module alu_control(
    input [1:0] alu_op,
    input [2:0] funct3,
    input funct7_bit30,
    output reg [2:0] alu_sel
);

always @(*) begin
    case (alu_op)

        // ADD: load, store, ADDI
        2'b00: alu_sel = 3'b000;

        // SUB: branches
        2'b01: alu_sel = 3'b001;

        // R-type instructions
        2'b10: begin
            case (funct3)
                3'b000: begin
                    if (funct7_bit30)
                        alu_sel = 3'b001; // SUB
                    else
                        alu_sel = 3'b000; // ADD
                end

                3'b111: alu_sel = 3'b010; // AND
                3'b110: alu_sel = 3'b011; // OR
                3'b100: alu_sel = 3'b100; // XOR
                3'b010: alu_sel = 3'b101; // SLT

                default: alu_sel = 3'b000;
            endcase
        end

        default: alu_sel = 3'b000;
    endcase
end

endmodule
