module riscv_cpu(
    input clk,
    input reset,
    output [31:0] debug_pc,
    output [31:0] debug_instruction,
    output [31:0] debug_result,
    output [31:0] debug_x1,
    output [31:0] debug_x2,
    output [31:0] debug_x3
);

    // 1. Program Counter
    wire [31:0] pc_current;
    wire [31:0] pc_next;



    pc pc_unit(
        .clk(clk),
        .reset(reset),
        .next_pc(pc_next),
        .current_pc(pc_current)
    );

    assign debug_pc = pc_current;

    // 2. Instruction Memory
    wire [31:0] instruction;

    instruction_memory imem(
        .address(pc_current),
        .instruction(instruction)
    );

    assign debug_instruction = instruction;

    // 3. Decode instruction fields
    wire [6:0] opcode = instruction[6:0];
    wire [4:0] rd = instruction[11:7];
    wire [2:0] funct3 = instruction[14:12];
    wire [4:0] rs1 = instruction[19:15];
    wire [4:0] rs2 = instruction[24:20];
    wire funct7_bit30 = instruction[30];

    // 4. Control Unit
    wire reg_write;
    wire alu_src;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire branch;

    control_unit control(
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch)
    );

    // 5. Register File
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] write_back;

    register_file regs(
        .clk(clk),
        .we(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_back),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // 6. Immediate Generator
    wire [31:0] immediate;

    imm_gen imm_unit(
        .instruction(instruction),
        .immediate(immediate)
    );


wire branch_equal;
assign branch_equal = (read_data1 == read_data2);

wire take_branch;
assign take_branch = branch &&
                     ((funct3 == 3'b000 && branch_equal) ||
                      (funct3 == 3'b001 && !branch_equal));

assign pc_next = take_branch ? pc_current + immediate : pc_current + 4;



    // 7. ALU input multiplexer
    wire [31:0] alu_input2;

    assign alu_input2 = alu_src ? immediate : read_data2;

    // 8. ALU Control
    wire [1:0] alu_op;
    wire [2:0] alu_sel;

 
assign alu_op = (opcode == 7'b0110011) ? 2'b10 :
                (opcode == 7'b1100011) ? 2'b01 :
                2'b00;


    alu_control alu_ctrl(
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7_bit30(funct7_bit30),
        .alu_sel(alu_sel)
    );

    // 9. ALU
    wire [31:0] alu_result;

    alu alu_unit(
        .a(read_data1),
        .b(alu_input2),
        .op(alu_sel),
        .result(alu_result)
    );

    assign debug_result = alu_result;
  

    // Temporary debug output: inspect register x1
    assign debug_x1 = regs.registers[1];
    assign debug_x2 = regs.registers[2];
    assign debug_x3 = regs.registers[3];

    // 10. Data Memory
    wire [31:0] memory_data;

    data_memory dmem(
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(memory_data)
    );

    // 11. Write-back multiplexer
    assign write_back = mem_to_reg ? memory_data : alu_result;

endmodule