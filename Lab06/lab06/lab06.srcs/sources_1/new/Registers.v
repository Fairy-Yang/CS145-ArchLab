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
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] shamt,
    input [4:0] writeReg,
    input [31:0] writeData,
    input [31:0]PC_add_4,
    input regWrite,
    input Clk,
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    input reset,
    input jal,
    input shift
    );
    
    reg [31:0] regFile[0:31];
    integer i=0;
    
    always @ (*)
    begin
        if(shift == 1) begin
            readData1 = regFile[readReg2];
            readData2 = shamt;
        end
        else begin
            readData1 = regFile[readReg1];
            readData2 = regFile[readReg2];
        end
        
    end
    
    always @ (posedge Clk or reset)
        begin
            if(reset)
            begin
                for(i=0; i<32; i=i+1) begin
                    regFile[i] = i;
                    if(i == 16)
                        regFile[i] = 68;
                end
               /* for(i=0; i<32; i=i+1)
                    regFile[i] = 0;*/
            end
            
            if(regWrite) begin
                if(jal == 1)
                    regFile[31] <= PC_add_4;
                else begin
                    regFile[writeReg] = writeData;    
                    //$display("writeReg is:%d, writeData is:%d", writeReg, regFile[writeData]);
                end
            end 
        end
endmodule
