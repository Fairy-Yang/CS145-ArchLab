`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/31 09:46:09
// Design Name: 
// Module Name: Mux_Up_left
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


module Mux_Up_left(
    input [31:0] input1,
    input [31:0] input2,
    input SEL,
    output reg [31:0] Mux_UL_Out
    );
    
    always @(input1 or input2 or SEL)
        Mux_UL_Out = SEL?input1:input2;
endmodule
