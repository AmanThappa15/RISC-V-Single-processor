module control_unit_tb;

reg [6:0] opcode;

wire reg_write;
wire alu_src;
wire mem_read;
wire mem_write;
wire mem_to_reg;

control_unit uut(
    .opcode(opcode),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg)
);

initial begin

    $monitor("opcode=%b | reg_write=%b alu_src=%b mem_read=%b mem_write=%b mem_to_reg=%b",
             opcode, reg_write, alu_src, mem_read, mem_write, mem_to_reg);

    // R-type
    opcode = 7'b0110011;
    #10;

    // addi
    opcode = 7'b0010011;
    #10;

    // lw
    opcode = 7'b0000011;
    #10;

    // sw
    opcode = 7'b0100011;
    #10;

    $finish;

end

endmodule