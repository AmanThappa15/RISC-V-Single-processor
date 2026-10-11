module instruction_memory(
    input [31:0] address,
    output [31:0] instruction
);

reg [31:0] memory [0:255];


integer i;

initial begin
    // ADD THIS LOOP ABOVE memory[0]
    for (i = 0; i < 256; i = i + 1) begin
        memory[i] = 32'h00000013; // NOP
    end

    // Keep your existing instructions BELOW the loop
    


memory[0]  = 32'h00A00093; // addi x1, x0, 10
memory[1]  = 32'h01400113; // addi x2, x0, 20
memory[2]  = 32'h002081B3; // add  x3, x1, x2  -> 30
memory[3]  = 32'h401101B3; // sub  x3, x2, x1  -> 10
memory[4]  = 32'h0020F1B3; // and  x3, x1, x2  -> 0
memory[5]  = 32'h0020E1B3; // or   x3, x1, x2  -> 30
memory[6]  = 32'h0020A1B3; // slt  x3, x1, x2  -> 1
memory[7]  = 32'h001121B3; // slt  x3, x2, x1  -> 0
memory[8]  = 32'h00209463; // bne  x1, x2, +8  -> taken
memory[9]  = 32'h06300193; // addi x3, x0, 99  -> skipped
memory[10] = 32'h00700193; // addi x3, x0, 7   -> executed



end



assign instruction =memory[address[9:2]];
endmodule