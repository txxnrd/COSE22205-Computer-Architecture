# COSE22205-Computer-Architecture

This repository contains the implementation of a basic CPU architecture using SystemVerilog. The project demonstrates the design and simulation of a CPU with several key components. Below is a detailed description of each component.

## Components

### Arithmetic Logic Unit (ALU)

The ALU is responsible for performing arithmetic and logical operations. It takes operands from the registers and executes operations such as addition, subtraction, AND, OR, and XOR based on the control signals.

### Instruction Memory (imem1.sv)

The Instruction Memory stores the instructions that the CPU executes. It is a read-only memory initialized with the program instructions. The CPU fetches instructions from this memory during the fetch stage of the instruction cycle.

### Data Memory (dmem1.sv)

The Data Memory is used for storing data that the program operates on. It supports both read and write operations. The CPU accesses this memory during the load/store operations.

### Controller

The Controller manages the operation of the CPU by generating control signals based on the current instruction. It coordinates the fetching, decoding, execution, memory access, and write-back stages of the instruction cycle.

### Register File

The Register File consists of a set of registers used for storing temporary data and operands. It provides read and write access to the registers. The CPU uses these registers to hold intermediate values and results of computations.

## Implementation Details

- **Language:** SystemVerilog
- **CPU Structure:** The CPU is designed as a multi-stage pipeline with components interacting to execute instructions efficiently.

## Getting Started

To run the simulation of the CPU architecture, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/txxnrd/COSE22205-Computer-Architecture.git
   ```
