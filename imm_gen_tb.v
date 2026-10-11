module imm_gen_tb;

reg [31:0] instruction;
wire [31:0] immediate;
wire signed [31:0] signed_immediate = immediate;

imm_gen uut(
    .instruction(instruction),
    .immediate(immediate)
);

initial begin

    $monitor("instruction=%h | immediate=%h (%0d)",
             instruction, immediate, signed_immediate);

    // addi x1, x0, 10
    instruction = 32'h00A00093;
    #10;

    // addi x1, x0, -1
    instruction = 32'hFFF00093;
    #10;

    // sw x2, 8(x1)
    instruction = 32'h0020A423;
    #10;

    $finish;

end

endmodule