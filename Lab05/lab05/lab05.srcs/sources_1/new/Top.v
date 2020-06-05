`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/30 14:41:00
// Design Name: 
// Module Name: Top
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


module Top(
    input Clk,
    input reset
    );
    
    //pc
    wire [31:0]PC_out;
    wire [31:0]PC_In;
    
    //InstMemory
     wire [31:0]Inst;
     
     //sign extend
     wire [31:0] extData;
     
    //main control
    wire  regDst,
          aluSrc,
          memToReg,
          regWrite,
          memRead,
          memWrite,
          branch,
          jump;
    wire [1:0] aluOp;
    wire andi,
        ori;
    
    //register
     wire [31: 0] readData1;
    wire [31: 0] readData2;
    wire [4 : 0] writeReg = regDst? Inst[15:11]:Inst[20:16];
    wire [31:0]writeData = memToReg? readData : aluRes;
    wire jal_flag;
    
    //ALU
    wire zero;
   
    wire [31:0] aluRes;
    
    //ALU control
    wire [3:0]ALUCtrOut;
    wire shift_flag;
    wire jr_flag;
     
    //dataMemory
    wire[31:0] readData;
     
    //shift left
    wire [27:0] shift_data;
     
    //jump address
    wire [31:0]jump_address;
    wire [31:0]PC_add_4;
    wire [31:0]AddRes;
    wire [31:0]addIn2 = extData<<2;
    wire [31:0]MUX_left_out = (branch & zero)?AddRes:PC_add_4;
    wire [31:0]MUX_right_out = jump? jump_address:MUX_left_out;
    assign PC_In = jr_flag? readData1 : MUX_right_out;
    
    PC pc(
        .PC_In(PC_In),
        .PC_out(PC_out),
        .Clk(Clk),
        .reset(reset)
    );
    
    PC_adder_4 pc_add_4(
        .input1(PC_out),
        .PC_add_4(PC_add_4)
    );
    
    jump_address j_a(
        .jump_address(jump_address),
        .PC_add_4(PC_add_4),
        .Inst(shift_data)
    );
    
    shift_26_to_28 shift1(
        .Inst(Inst[25:0]),
        .shift_data(shift_data)
    );
    
    Adder adder(
        .input1(PC_add_4),
        .input2(addIn2),
        .Out(AddRes)
    );
    
    InstMemory instmemory(
        .PC_out(PC_out),
        .Clk(Clk),
        .Inst(Inst)
    );
    
    Ctr mainCtr(
        .opCode(Inst[31:26]),
        .regDst(regDst),
        .aluSrc(aluSrc),
        .memToReg(memToReg),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .branch(branch),
        .aluOp(aluOp),
        .jump(jump),
        .andi(andi),
        .ori(ori),
        .jal(jal_flag)
    );
    
    ALUCtr aluctr(
        .ALUCtrOut(ALUCtrOut),
        .shift(shift_flag),
        .ALUOp(aluOp),
        .Funct(Inst[5:0]),
        .andi(andi),
        .ori(ori),
        .jr_flag(jr_flag)
    );
    
    signext sext(
         .inst(Inst[15:0]),
         .data(extData)
    );
    
    wire [31:0] ALU_input2 = aluSrc? extData : readData2;
    ALU alu(
        .aluCtr(ALUCtrOut),
        .aluRes(aluRes),
        .input1(readData1),
        .input2(ALU_input2),
        .shift_val(Inst[10:6]),
        .zero(zero)
    );
    
    dataMemory datamemory(
        .Clk(Clk),
        .address(aluRes),
        .writeData(readData2),
        .memWrite(memWrite),
        .memRead(memRead),
        .readData(readData)
    );
    
    Registers register(
        .readReg1(Inst[25:21]),
        .readReg2(Inst[20:16]),
        .writeReg(writeReg),
        .writeData(writeData),
        .regWrite(regWrite),
        .Clk(Clk),
        .readData1(readData1),
        .readData2(readData2),
        .reset(reset),
        .shift(shift_flag),
        .jal_flag(jal_flag),
        .jr_flag(jr_flag),
        .PC_add_4(PC_add_4)
    );
endmodule