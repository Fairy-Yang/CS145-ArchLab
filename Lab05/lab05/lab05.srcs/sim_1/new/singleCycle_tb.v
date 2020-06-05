`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/30 16:35:38
// Design Name: 
// Module Name: singleCycle_tb
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


module singleCycle_tb(
    );
    reg Clk;
    reg reset;
    
    Top top(
        .Clk(Clk),
        .reset(reset)
    );
    
    always #20 Clk = ~Clk;
    initial begin
        $readmemh("C:/Users/Administrator/Desktop/lab5/lab05/lab05.srcs/Src/Data.txt", top.datamemory.memFile, 0);
        $readmemb("C:/Users/Administrator/Desktop/lab5/lab05/lab05.srcs/Src/Inst.txt", top.instmemory.instfile, 0);
        Clk = 1;
        reset = 1;
        top.pc.PC_out = 0;
        #10 reset = 0;
        #600;
    end
    
    
endmodule
