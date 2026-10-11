module control_unit(
    input [6:0] opcode,

    output reg reg_write,
    output reg alu_src,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg branch
);

always @(*) begin

    // Default values: disable all controls
    reg_write = 0;
    alu_src = 0;
    mem_read = 0;
    mem_write = 0;
    mem_to_reg = 0;
    branch = 1'b0;

    case (opcode)

        // R-type: add, sub, and, or, xor
        7'b0110011: begin
            reg_write = 1;
        end

        // I-type: addi
        7'b0010011: begin
            reg_write = 1;
            alu_src = 1;
        end

        // Load: lw
        7'b0000011: begin
            reg_write = 1;
            alu_src = 1;
            mem_read = 1;
            mem_to_reg = 1;
        end

        // Store: sw
        7'b0100011: begin
            alu_src = 1;
            mem_write = 1;
        end
        7'b1100011: begin // Branch instructions, e.g. BEQ
    branch = 1'b1;
    reg_write = 1'b0;
    alu_src = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b0;
    mem_to_reg = 1'b0;
end

        default: begin
            // Keep all controls disabled
        end

    endcase

end

endmodule