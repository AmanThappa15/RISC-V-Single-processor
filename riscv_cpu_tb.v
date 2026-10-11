`timescale 1ns/1ps

module riscv_cpu_tb;

    reg clk;
    reg reset;

    wire [31:0] debug_pc;
    wire [31:0] debug_instruction;
    wire [31:0] debug_result;
    wire [31:0] debug_x1;
    wire [31:0] debug_x2;
    wire [31:0] debug_x3;

    riscv_cpu uut(
        .clk(clk),
        .reset(reset),
        .debug_pc(debug_pc),
        .debug_instruction(debug_instruction),
        .debug_result(debug_result),
        .debug_x1(debug_x1),
        .debug_x2(debug_x2),
        .debug_x3(debug_x3)
    );

    // Generate a clock with a 10 ns period
    always #5 clk = ~clk;

    initial begin

      
$monitor(
    "Time=%0t | PC=%h | instruction=%h | ALU=%h | x1=%0d | x2=%0d | x3=%0d",
    $time,
    debug_pc,
    debug_instruction,
    debug_result,
    debug_x1,
    debug_x2,
    debug_x3
);


        clk = 0;
        reset = 1;

        // Hold reset for one clock period
        #10;
        reset = 0;

        // Allow more instructions to execute
        #200;

        $finish;

    end

endmodule