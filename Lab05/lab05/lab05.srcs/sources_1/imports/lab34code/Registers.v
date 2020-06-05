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
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    input Clk,
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    input reset,
    input shift,
    input jal_flag,
    input jr_flag,
    input [31:0]PC_add_4
    );
    
    reg [31:0] regFile[0:31];
    integer i=0;
    
    always @ (readReg1 or readReg2 or shift or jal_flag)
        begin
            if(shift == 0)
            begin
                readData1 = regFile[readReg1];
                readData2 = regFile[readReg2];
            end
            else
            begin
                readData1 = regFile[readReg2];
            end
            
            if(jal_flag == 1)
            begin
                regFile[31]=PC_add_4;
            end
            
            if(jr_flag == 1)
            begin
                readData1 = regFile[readReg1];
            end
        end
    
    always @ (posedge Clk or reset)
        begin
            if(reset)
            begin
                for(i=0; i<32; i=i+1)
                    regFile[i] = 32'b00000000;
            end
            if(regWrite)
                regFile[writeReg] = writeData;
        end
endmodule
