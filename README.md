# Simple 4BIT CPU for Terasic DE1-SOC

The goal of this project was to implement a simple CPU to learn VHDL and FPGA programming.

This project implements a very simple 4 BIT CPU that can run on the Terasic DE1-SOC board.
THE CPU has 16 Byte of RAM and a 4 BIT ALU.

IT currently offers 5 Commands, more can easily be added to the Control unit:
*   LDA (0001), load a value into register A
*   OUT (0010), outputs the value of register A into the Out register
*   LDB (0011), loads a value into register B
*   ADD (0100), adds value of register B into the A register
*   JMP (0101), jumps to the given register

A simple program is predefined inside memory.vhd

Other commands that can be added easily are:
*   SUB: subtract
*   SAVEA: save the value of a register inside memory

Conditional Jumps should also be relativly easy to implement, a control line between the ALU and the ControlUnit would need to be added.