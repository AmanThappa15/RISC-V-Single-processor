
module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] op,
    output reg [31:0] result
);

always @(*) begin
    case (op)
        3'b000: result = a + b; // ADD
        3'b001: result = a - b; // SUB
        3'b010: result = a & b; // AND
        3'b011: result = a | b; // OR
        3'b100: result = a ^ b; // XOR
        3'b101: begin           // SLT
            if ($signed(a) < $signed(b))
                result = 32'd1;
            else
                result = 32'd0;
        end
        default: result = 32'b0;
    endcase
end

endmodule
