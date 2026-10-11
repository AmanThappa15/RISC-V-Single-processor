module data_memory_tb;

reg clk;
reg mem_read;
reg mem_write;
reg [31:0] address;
reg [31:0] write_data;

wire [31:0] read_data;

data_memory uut(
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(address),
    .write_data(write_data),
    .read_data(read_data)
);

always #5 clk = ~clk;

initial begin

    $monitor("Time=%0t | read=%b write=%b addr=%h wdata=%h rdata=%h",
             $time, mem_read, mem_write, address, write_data, read_data);

    clk = 0;
    mem_read = 0;
    mem_write = 0;
    address = 0;
    write_data = 0;

    // Store 100 at address 0
    #2;
    mem_write = 1;
    address = 0;
    write_data = 32'd100;
    #10;

    // Store 200 at address 4
    address = 4;
    write_data = 32'd200;
    #10;

    // Read address 0
    mem_write = 0;
    mem_read = 1;
    address = 0;
    #10;

    // Read address 4
    address = 4;
    #10;

    $finish;

end

endmodule