`timescale 1ns/1ps

module mux_tb;

reg a;
reg b;
reg s;
wire y;

mux uut(
    .a(a),
    .b(b),
    .s(s),
    .y(y)
);

initial begin

    $dumpfile("mux.vcd");
    $dumpvars(0, mux_tb);

    $monitor("Time=%0t | a=%b b=%b s=%b | y=%b",
             $time, a, b, s, y);

    // s = 0 → y should be a
    a = 0; b = 1; s = 0;
    #10;

    a = 1; b = 0; s = 0;
    #10;

    // s = 1 → y should be b
    a = 0; b = 1; s = 1;
    #10;

    a = 1; b = 0; s = 1;
    #10;

    $finish;

end

endmodule