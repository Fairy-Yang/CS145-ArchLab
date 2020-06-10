`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 16:30:57
// Design Name: 
// Module Name: pipeline_tb
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


module pipeline_tb(
    );
    
    reg Clk;
    reg reset;
    Top top(
        .Clk(Clk),
        .reset(reset)
    );
    
    always #20 Clk = ~Clk;
    initial begin
        $readmemh("C:/Users/Administrator/Desktop/lab6/lab06/lab06.srcs/Src/Data.txt", top.datamemory.memFile, 0);
        $readmemb("C:/Users/Administrator/Desktop/lab6/lab06/lab06.srcs/Src/Inst.txt", top.instmemory.instfile, 0);
        Clk = 0;
        reset = 1;
        top.mainCtr.regDst = 0;
        top.mainCtr.aluSrc = 0;
        top.mainCtr.memToReg = 0;
        top.mainCtr.regWrite = 0;
        top.mainCtr.memRead = 0;
        top.mainCtr.memWrite = 0;
        top.mainCtr.branch = 0;
        top.mainCtr.aluOp = 0;
        top.mainCtr.shift = 0;
        top.mainCtr.andi = 0;
        top.mainCtr.ori = 0;
        top.mainCtr.jump = 0;
        top.mainCtr.jal = 0;
        top.mainCtr.jr = 0;
        
        
        top.IF_to_ID_next_inst_pc = 32'h00000000;
        top.IF_to_ID_inst = 32'h00000000;
        
        top.ID_to_EX_next_inst_pc = 32'h00000000;
        top.ID_to_EX_inst = 32'h00000000;
        top.ID_to_EX_readData1 = 32'h00000000;
        top.ID_to_EX_readData2 = 32'h00000000;
        top.ID_to_EX_imme = 32'h00000000;
        top.ID_to_EX_rt = 5'b00000;
        top.ID_to_EX_rd= 5'b00000;
        top.ID_to_EX_rs = 5'b00000;
        top.ID_to_EX_shamt = 5'b00000;
        top.ID_to_EX_jr = 0;
    
        //control signal
        top.ID_to_EX_Ctr_Signal = 12'h000;
        top.EX_to_MEM_zero = 0;
        top.EX_to_MEM_aluRes = 32'h00000000;
        top.EX_to_MEM_branch_address = 32'h00000000;
        top.EX_to_MEM_writeData = 32'h00000000;
        top.EX_to_MEM_rt_or_rd = 5'b00000;
    
        //control signal
        top.EX_to_MEM_Ctr_Signal = 5'b00000;
    
        top.MEM_to_WB_readData = 32'h00000000;
        top.MEM_to_WB_aluRes = 32'h00000000;
        top.MEM_to_WB_rt_or_rd = 5'b00000;
    
        //control signal
       top.MEM_to_WB_Ctr_Signal = 2'b00;
        #20 reset = 0;
        #600;
    end
endmodule
