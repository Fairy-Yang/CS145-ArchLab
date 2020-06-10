`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 09:43:13
// Design Name: 
// Module Name: ALUCtr
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


module ALUCtr(
    output reg [3:0] ALUCtrOut,
    input [1:0] ALUOp,
    input [5:0] Funct,
    input andi,
    input ori
    );
        
    always @ ({ALUOp, Funct, andi, ori})
    begin
        casex   ({ALUOp, Funct, andi, ori})
            10'b00xxxxxx10 : ALUCtrOut = 4'b0000; //andi
            10'b00xxxxxx01 : ALUCtrOut = 4'b0001; //ori
            10'b00xxxxxx00 : ALUCtrOut = 4'b0010;
            10'b01xxxxxx00 : ALUCtrOut = 4'b0110;
            
            //R type
            10'b1x10000000 : ALUCtrOut = 4'b0010; //add
            10'b1x10001000 : ALUCtrOut = 4'b0110; //sub
            10'b1x10010000 : ALUCtrOut = 4'b0000; //and
            10'b1x10010100 : ALUCtrOut = 4'b0001; //or
            10'b1x10101000 : ALUCtrOut = 4'b0111; //slt
            10'b1x00000000 : ALUCtrOut = 4'b0011; //sll
            10'b1x00001000 : ALUCtrOut = 4'b0100; //srl       
            10'b1x00100000 : ALUCtrOut = 4'b0101; //jr
            
         endcase
    end
endmodule
