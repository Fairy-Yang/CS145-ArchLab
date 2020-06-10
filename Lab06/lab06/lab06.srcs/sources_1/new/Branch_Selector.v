`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 10:56:23
// Design Name: 
// Module Name: Branch_Selector
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


module Branch_Selector(
    input [31:0] input1,
    input [31:0] input2,
    input SEL,
    output reg [31:0] branch_address
    );
    
    initial begin
        branch_address = 0;
    end
    
    always @(input1 or input2 or SEL)
        assign branch_address = SEL? input2:input1;
endmodule
