`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 09:53:23
// Design Name: 
// Module Name: ALUCtr_tb
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


module ALUCtr_tb();
    wire [3:0] ALUCtrOut;
    reg [1:0] ALUOp;
    reg [5:0] Funct;
    
    ALUCtr u0(
        .ALUOp(ALUOp),
        .Funct(Funct),
        .ALUCtrOut(ALUCtrOut)
    );
    
    initial begin
        //Initialize Inputs
        ALUOp = 2'b00;
        Funct = 6'b000000;
        
        #100
        //sw, lw
        ALUOp = 2'b00;
        Funct = 6'bxxxxxx;
        
        //beq
        #100 
        ALUOp = 2'b01;
        Funct = 6'bxxxxxx;
        
        //add
         #100 
        ALUOp = 2'b1x;
        Funct = 6'bxx0000;
        
        //sub
        #100;
        ALUOp = 2'b1x;
        Funct = 6'bxx0010;
        
        //AND
         #100 ;
        ALUOp = 2'b1x;
        Funct = 6'bxx0100;
        
        //OR
         #100 ;
        ALUOp = 2'b1x;
        Funct = 6'bxx0101;
        
        //slt
         #100 ;
        ALUOp = 2'b1x;
        Funct = 6'bxx1010;
    end
    
endmodule
