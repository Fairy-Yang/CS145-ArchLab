`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/31 09:24:48
// Design Name: 
// Module Name: jump_address
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


module jump_address(
    input [27:0] Inst,
    input [31:0] PC_add_4,
    output reg [31:0] jump_address
    );
    
    always @(Inst or PC_add_4)
    begin
        jump_address[27:0] = Inst[27:0];
        jump_address[31:28] = PC_add_4[31:28];
        $display(jump_address);
    end
endmodule
