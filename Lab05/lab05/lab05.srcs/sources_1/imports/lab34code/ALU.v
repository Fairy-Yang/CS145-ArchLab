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
    output reg [31:0] aluRes,
    input [31:0] input1,
    input [31:0] input2,
    input [4:0] shift_val,
    output reg zero
    );
    
    always @ (input1 or input2 or aluCtr)
    begin
        if(aluCtr == 4'b0010)   //add
            aluRes = input1 + input2;
            
        else if(aluCtr == 4'b0110)  //sub
            aluRes = input1 - input2;
        
        else if(aluCtr == 4'b0001)  //OR
            aluRes = input1 | input2;
            
        else if(aluCtr == 4'b0000)  //AND
            aluRes = input1 & input2;
            
        else if(aluCtr == 4'b0111)  //slt
            if(input1 < input2)
                aluRes = 1;
            else
                aluRes = 0; 
                
        else if(aluCtr == 4'b0011)  //sll
            aluRes = (input1 << shift_val);
            
        else if(aluCtr == 4'b0100)  //srl
            aluRes = (input1 >> shift_val);
            
        else if(aluCtr == 4'b0101)  //j
            aluRes = input1;
            
        else    //NOR
            aluRes = ~(input1 | input2);
        
        if(aluRes == 0)
            zero = 1;
        else
            zero = 0;     
    end
endmodule
