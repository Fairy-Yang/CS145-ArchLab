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
    output reg shift,
    input [1:0] ALUOp,
    input [5:0] Funct,
    input andi,
    input ori,
    output reg jr_flag
    );
        
    

    always @ (ALUOp or Funct or andi or ori)
    begin
        shift = 0;
        jr_flag = 0;
        casex   ({ALUOp, Funct, andi, ori})
            10'b00xxxxxx00 : ALUCtrOut = 4'b0010;
            10'b01xxxxxx00 : ALUCtrOut = 4'b0110;
            10'b1x10000000 : ALUCtrOut = 4'b0010;  
            10'b1x10001000 : ALUCtrOut = 4'b0110;
            10'b1x10010000 : ALUCtrOut = 4'b0000;
            10'b1x10010100 : ALUCtrOut = 4'b0001;
            10'b1x10101000 : ALUCtrOut = 4'b0111;
            10'b1x00000000 :    //sll
            begin
                ALUCtrOut = 4'b0011;
                shift = 1;
            end
            10'b1x00001000 :    //srl
            begin
                ALUCtrOut = 4'b0100;
                shift = 1;
            end
            10'b1xxxxxxx10 : ALUCtrOut = 4'b0000;
            10'b1xxxxxxx01 : ALUCtrOut = 4'b0001;
            10'b1x00100000 : 
            begin
                ALUCtrOut = 4'b0101;
                jr_flag = 1;
            end
        endcase
    end
endmodule
