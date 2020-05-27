`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 11:43:42
// Design Name: 
// Module Name: Registers
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Registers(
    input [25:21] readReg1,
    input [21:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    input Clk,
    output [31:0] readData1,
    output [31:0] readData2
    );
    
    reg [31:0] regFile[31:0];
    reg [31:0] ReadData1;
    reg [31:0] ReadData2;
    
    always @ (readReg1 or readReg2 or writeReg)
        begin
            ReadData1 = regFile[readReg1];
            ReadData2 = regFile[readReg2];
        end
    
    assign readData1 = ReadData1;
    assign readData2 = ReadData2; 
    
    always @ (negedge Clk)
        begin
            if(regWrite)
                regFile[writeReg] = writeData;
        end
endmodule
