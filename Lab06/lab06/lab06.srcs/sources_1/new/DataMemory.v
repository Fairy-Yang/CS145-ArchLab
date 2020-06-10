`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 09:48:01
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input Clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output reg [31:0] readData
    );
    
    reg [31:0] memFile[0:63];
    
    always @ (memRead)
    begin
        if(memRead)
        begin
            readData = memFile[address];
        end
        else
            readData = 0;
    end
    
    always @ (negedge Clk)
    begin
        if(memWrite)
                memFile[address] <= writeData;
    end
endmodule
