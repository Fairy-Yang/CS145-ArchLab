`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 11:15:11
// Design Name: 
// Module Name: ALU_tb
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

module ALU_tb( );
    reg [3:0] aluCtr;
    reg [31:0] input1;
    reg [31:0] input2;
    wire [31:0] aluRes;
    wire zero;

    ALU u0(
        .aluCtr(aluCtr),
        .input1(input1),
        .input2(input2),
        .aluRes(aluRes),
        .zero(zero)
    );

    initial begin
        //Initialize Inputs
        input1 = 0;
        input2 = 0;
        aluCtr = 4'b0000;

        //add
        #100
        input1 = 14;
        input2 = 13;
        aluCtr = 4'b0010;
        
        //sub
        #100
        input1 = 14;
        input2 = 13;
        aluCtr = 4'b0110;

        //AND
        #100
        input1 = 14;
        input2 = 13;
        aluCtr = 4'b0000;

        //or
        #100
        input1 = 14;
        input2 = 13;
        aluCtr = 4'b0001;    

        //slt
        #100
        input1 = 12;
        input2 = 13;
        aluCtr = 4'b0111;

        //NOR
        #100;
        input1 = 32'h00000101;
        input2 = 32'h00001010;
        aluCtr = 4'b1100;
        
    end
endmodule