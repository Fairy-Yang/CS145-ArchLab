`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 10:56:23
// Design Name: 
// Module Name: writeData_Selector
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


module writeData_Selector(
    output reg [31:0] writeData_select,
    input [31:0] input1,
    input [31:0] input2,
    input SEL
    );
    initial begin
        writeData_select = 0;
    end
    
    always @(input1 or input2 or SEL)
        assign writeData_select = SEL? input2:input1;
    
endmodule
