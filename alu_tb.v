`timescale 1ns/1ps

module alu_tb;

reg [31:0] a;
reg [31:0] b;
reg [2:0] op;

wire [31:0] result;

alu uut(
    .a(a),
    .b(b),
    .op(op),
    .result(result)
);

initial begin

    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);

    $monitor("Time=%0t | a=%h b=%h op=%b | result=%h",
             $time, a, b, op, result);

    // ADD
    a = 32'd10;
    b = 32'd5;
    op = 3'b000;
    #10;

    // SUB
    op = 3'b001;
    #10;

    // AND
    a = 32'h0F0F0F0F;
    b = 32'h00FF00FF;
    op = 3'b010;
    #10;

    // OR
    op = 3'b011;
    #10;

    // XOR
    op = 3'b100;
    #10;

    $finish;

end

endmodule