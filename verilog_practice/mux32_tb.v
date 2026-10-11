`timescale 1ns/1ps
module mux32_tb;
reg [31:0] a;
reg [31:0] b;
reg s;
wire [31:0] y;
mux32 uut(
    .a(a),
    .b(b),
    .s(s),
    .y(y)
);
initial begin
  $dumpfile("mux32.vcd");
  $dumpvars(0,mux32_tb);
  $monitor("Time=%0t | a=%h b=%h s=%b | y=%h",
   $time, a,b,s,y);
   a = 32'h00000005;
   b = 32'h0000000A;
   s = 0;
   #10;
   s=1;
   #10;
   a = 32'h12345678;
   b = 32'hABCDEF01;
   s = 0;
   #10;
   s=1;
   #10;
   $finish;
end
endmodule