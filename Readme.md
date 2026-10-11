# Single-Cycle RISC-V Processor in Verilog

A 32-bit single-cycle RISC-V processor designed and simulated using Verilog HDL. This project demonstrates the fundamental components of a CPU, including instruction fetching, decoding, arithmetic and logical operations, memory access, branching, and register write-back.

The processor is built using separate Verilog modules to make the design easier to understand, test, and debug.

## Project Objectives

- Understand the internal working of a basic processor.
- Implement a modular CPU datapath using Verilog.
- Design an Arithmetic Logic Unit (ALU) and register file.
- Implement instruction and data memory.
- Support basic arithmetic, logical, load/store, and branch instructions.
- Verify processor behavior through simulation using Icarus Verilog.

## Project Status

The current implementation supports a basic subset of RISC-V instructions. Arithmetic, logical, branch, and memory operations have been tested through simulation.

**Note:** This is an educational implementation of a limited instruction subset, not a complete RISC-V ISA implementation.
## Features

- 32-bit single-cycle processor architecture.
- Modular design using Verilog HDL.
- Program Counter (PC) for instruction sequencing.
- Instruction memory with predefined test instructions.
- Register file with two read ports and one write port.
- Register `x0` is hardwired to zero.
- Immediate generator for I-type, S-type, and B-type instructions.
- ALU supporting arithmetic and logical operations.
- Data memory supporting load and store operations.
- Conditional branching with PC updates.
- Simulation and verification using Icarus Verilog.

## Supported Instructions

| Instruction | Description |
|---|---|
| `ADD` | Adds two register values |
| `SUB` | Subtracts one register value from another |
| `AND` | Bitwise AND |
| `OR` | Bitwise OR |
| `XOR` | Bitwise XOR |
| `SLT` | Sets the result to 1 if the first signed value is less than the second |
| `ADDI` | Adds a sign-extended immediate to a register |
| `LW` | Loads a word from data memory |
| `SW` | Stores a word in data memory |
| `BEQ` | Branches if two register values are equal |
| `BNE` | Branches if two register values are not equal |
## Tools and Technologies

- **HDL:** Verilog
- **Code Editor:** Visual Studio Code
- **Simulator:** Icarus Verilog
- **Waveform Viewer:** GTKWave
- **Version Control:** Git and GitHub

## How to Run the Project

### 1. Install Icarus Verilog

Install Icarus Verilog and ensure that `iverilog` and `vvp` are available in your terminal.

### 2. Open the project directory

Open the project folder in VS Code and launch the terminal.

### 3. Compile the Verilog files

Run the following command in the terminal:

```bash
iverilog -g2012 -o riscv_sim riscv_cpu_tb.v riscv_cpu.v pc.v instruction_memory.v control_unit.v register_file.v imm_gen.v alu_control.v alu.v data_memory.v
```

### 4. Run the simulation

```bash
vvp riscv_sim
```

The terminal displays the simulation output, including the program counter, current instruction, ALU result, and selected register values.

### 5. View waveforms (optional)

To generate a waveform, the testbench must include VCD dump commands such as `$dumpfile` and `$dumpvars`.

After generating `riscv.vcd`, open it with:

```bash
gtkwave riscv.vcd
```

**Note:** The waveform commands must be added to the testbench before this optional step will work.