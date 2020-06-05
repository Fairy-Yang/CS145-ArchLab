`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/30 14:30:26
// Design Name: 
// Module Name: PC
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


module PC(
    input Clk,
    input [31:0] PC_In,
    output reg [31:0] PC_out,
    input reset
    );

    always @ (posedge Clk or reset)
    begin
        if(reset == 1)
            PC_out = 0;
        else
            PC_out = PC_In;
    end

endmodule
