`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 10:56:23
// Design Name: 
// Module Name: regDst_selector
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


module regDst_selector(
    output reg [4:0] reg_select,
    input [4:0] input1,
    input [4:0] input2,
    input SEL
    );
    
    initial begin
        reg_select = 0;
    end
    
    always @(input1 or input2 or SEL)
        assign reg_select = SEL? input2:input1;
endmodule
