`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/31 09:15:39
// Design Name: 
// Module Name: PC_adder_4
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


module PC_adder_4(
    input [31:0] input1,
    output reg [31:0] PC_add_4
    );
    
    always @ (input1)
        PC_add_4 = input1 + 4;
endmodule
