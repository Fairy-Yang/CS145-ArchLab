`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 09:53:58
// Design Name: 
// Module Name: dataMemory_tb
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


module dataMemory_tb();
    reg Clk;
    reg [31:0] address;
    reg [31:0] writeData;
    reg memWrite;
    reg memRead;
    wire [31:0] readData;
    
    dataMemory u0(
        .Clk(Clk),
        .address(address),
        .writeData(writeData),
        .memWrite(memWrite),
        .memRead(memRead),
        .readData(readData)
    );

    always #100 Clk = ~Clk;
    initial begin
        address = 32'h00000000;
        writeData = 32'h00000000;
        memWrite = 0;
        memRead = 0;
        Clk = 0;
    
        #185;
        memWrite = 1'b1;
        address = 32'h00000007;
        writeData = 32'hE0000000;

        #100;
        memWrite = 1'b1;
        writeData = 32'hffffffff;
        address = 32'h00000006;

        #185;
        memRead = 1'b1;
        memWrite = 1'b0;
        address = 32'h00000007;

        #80;
        memWrite = 1;
        address = 8;
        writeData = 32'haaaaaaaa;

        #80;
        memWrite = 0;
        memRead = 1;
        address = 6;
    end
endmodule
