`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/25 10:31:04
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [3:0] aluCtr,
    output [31:0] aluRes,
    input [31:0] input1,
    input [31:0] input2,
    output zero
    );
    
    reg Zero;
    reg [31:0] ALURes;
    
    always @ (input1 or input2 or aluCtr)
    begin
        if(aluCtr == 4'b0010)   //add
            ALURes = input1 + input2;
            
        else if(aluCtr == 4'b0110)  //sub
            ALURes = input1 - input2;
        
        else if(aluCtr == 4'b0001)  //OR
            ALURes = input1 | input2;
            
        else if(aluCtr == 4'b0000)  //AND
            ALURes = input1 & input2;
            
        else if(aluCtr == 4'b0111)  //slt
            if(input1 < input2)
                ALURes = 1;
            else
                ALURes = 0;
        
        else    //NOR
            ALURes = ~(input1 | input2);
        
        if(aluRes == 0)
                Zero = 1;
            else
                Zero = 0;     
    end
    
    assign aluRes = ALURes;
    assign zero = Zero;
endmodule
