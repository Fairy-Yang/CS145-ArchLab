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
    input [31:0] input1,
    input [31:0] input2,
    output reg [31:0] aluRes,
    output reg zero
    );
    
    initial begin
        zero = 0;
        aluRes = 0;
    end
    
    always @ (aluCtr or input1 or input2)
    begin
        if(aluCtr == 4'b0010)  //add
        begin
            aluRes = input1 + input2;
            $display("add, ALU input1: %d, ALU input2 is: %d, aluRes is: %d\n", input1, input2, aluRes); 
        end
            
        else if(aluCtr == 4'b0110)  //sub
        begin
            aluRes = input1 - input2;
            $display("sub, ALU input1: %d, ALU input2 is: %d, aluRes is: %d\n", input1, input2, aluRes);
        end
        
        else if(aluCtr == 4'b0001)  //OR
        begin
            aluRes = input1 | input2;
            $display("or, ALU input1: %d, ALU input2 is: %d, aluRes is: %d\n", input1, input2, aluRes);
        end
            
        else if(aluCtr == 4'b0000)  //AND
        begin
            aluRes = input1 & input2;
            $display("and, ALU input1: %d, ALU input2 is: %d, aluRes is: %d\n", input1, input2, aluRes);
        end
            
        else if(aluCtr == 4'b0111)  //slt
        begin
            if(input1 < input2)
                aluRes = 1;
            else
                aluRes = 0; 
            $display("slt, ALU input1: %d, ALU input2 is: %d, aluRes is: %d\n", input1, input2, aluRes);
         end       
         
        else if(aluCtr == 4'b0011)  //sll
        begin
            aluRes = (input1 << input2);
            $display("sll, ALU input1: %d, ALU input2 is: %d, aluRes is: %d\n", input1, input2, aluRes);
        end
        else if(aluCtr == 4'b0100)  //srl
        begin
            aluRes = (input1 >> input2);
            $display("srl, ALU input1: %d, ALU input2 is: %d, aluRes is: %d\n", input1, input2, aluRes);
        end
        else if(aluCtr == 4'b0101)  //j
        begin
            aluRes = input1;
            $display("j, ALU input1: %d, ALU input2 is: %d, aluRes is: %d\n", input1, input2, aluRes);
        end
        else    //NOR
        ;
        
        if(aluRes == 0)
            zero = 1;
        else
            zero = 0;
    end
endmodule