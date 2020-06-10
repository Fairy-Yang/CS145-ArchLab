`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 10:06:39
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] opCode,
    input [5:0] funct,
    output reg regDst,
    output reg aluSrc,
    output reg memToReg,
    output reg regWrite,
    output reg memRead,
    output reg memWrite,
    output reg branch,
    output reg [1:0] aluOp,
    output reg shift,
    output reg andi,
    output reg ori,
    output reg jump,
    output reg jal,
    output reg jr
    );
    
    always @ (opCode or funct)
    begin
        shift = 0;
        jr = 0;
        jump = 0;
        jal = 0;
        ori = 0;
        andi = 0;
        case(opCode)
        6'b000000:  //R type
        begin
            regDst = 1;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 2'b10;
            //jr
            if(funct == 6'b001000)
            begin
                jr = 1;
                jump = 1;
            end
            else begin
                jr = 0;
                jump = 0;
            end
                
            if(funct == 6'b000000 || funct == 6'b000010)    //sll, srl
                shift = 1;
            else
                shift = 0;
        end
        
        6'b100011:  //I type: lw
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 1;
            regWrite = 1;
            memRead = 1;
            memWrite = 0;
            branch = 0;
            aluOp = 2'b00;
            //$display("lw");
        end
        
        6'b101011:  //I type: sw
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 1;
            branch = 0;
            aluOp = 2'b00;
            //$display("sw");
        end
        
        6'b001000:   //I type: addi
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 2'b00;
            //$display("addi");
        end
        
        6'b001100:  //I type: andi
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 2'b00;
            andi = 1;
            //$display("andi");
        end
        
        6'b001101:  //I type: ori
        begin
            regDst = 0;
            aluSrc = 1;
            memToReg = 0;
            regWrite = 1;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 2'b00;
            ori = 1;
            //$display("ori");
        end
        
        
        6'b000100:  //I type: beq
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            branch = 1;
            aluOp = 2'b01;
            jump = 0;
            jr = 0;
            jal = 0;
            //$display("beq");
        end
        
        6'b000010:  //J type: j
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite =0;
            branch = 0;
            aluOp = 2'b00;
            jump = 1;
            //$display("jump");
        end
        
        6'b000011: //J type: jal
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite =0;
            branch = 0;
            aluOp = 2'b00;
            jal = 1;
            jump = 1;
           // $display("jal");
        end
        
        default:
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite =0;
            branch = 0;
            aluOp = 2'b00;
        end
    endcase
    end
endmodule
