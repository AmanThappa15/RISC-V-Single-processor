`timescale 1ns/1ps
module register_file_tb;
reg clk;
reg we;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;
register_file uut (
    .clk(clk),
    .we(we),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);
always #5 clk = ~clk;
initial begin 
    $dumpfile("register_file.vcd");
    $dumpvars(0, register_file_tb);
    $monitor("Time=%0t | we=%b rd=x%0d data=%h | rs1=x%0d -> %h | rs2=x%0d -> %h",
        $time, we, rd, write_data,
        rs1, read_data1,
        rs2, read_data2);
  clk = 0;
  we = 0;
  rs1=0;
  rs2=0;
  rd=0;
  write_data=0;
  #10;
   we = 1;
   rd = 1;
   write_data = 32'd100;
   #10;
   rd = 2;
   write_data = 32'd200;
   #10;
   we=0;
   rs1=1;
   rs2=2;
   #10;
   we=1;
   rd = 0;
   write_data = 32'd999;
   #10;
   we=0;
   rs1=0;
   #10;
   $finish;
end
endmodule
