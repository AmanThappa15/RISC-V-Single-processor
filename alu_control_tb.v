module alu_control_tb;

reg [1:0] alu_op;
reg [2:0] funct3;
reg funct7_bit30;

wire [2:0] alu_sel;

alu_control uut(
    .alu_op(alu_op),
    .funct3(funct3),
    .funct7_bit30(funct7_bit30),
    .alu_sel(alu_sel)
);

initial begin

    $monitor("alu_op=%b funct3=%b bit30=%b | alu_sel=%b",
             alu_op, funct3, funct7_bit30, alu_sel);

    // ADD
    alu_op = 2'b10;
    funct3 = 3'b000;
    funct7_bit30 = 0;
    #10;

    // SUB
    funct7_bit30 = 1;
    #10;

    // AND
    funct3 = 3'b111;
    funct7_bit30 = 0;
    #10;

    // OR
    funct3 = 3'b110;
    #10;

    // XOR
    funct3 = 3'b100;
    #10;

    // LW should use ADD
    alu_op = 2'b00;
    #10;

    $finish;

end

endmodule