`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 08:48:03
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
    
    //----------registers wire for IF to ID-------------
    reg [31:0] IF_to_ID_next_inst_pc;
    reg [31:0] IF_to_ID_inst;
    wire [4:0] IF_to_ID_rs =  IF_to_ID_inst[25:21];
    wire [4:0] IF_to_ID_rt = IF_to_ID_inst[20:16];
    wire [4:0] IF_to_ID_rd = IF_to_ID_inst[15:11];
    wire [4:0] IF_to_ID_shamt = IF_to_ID_inst[10:6];
    //--------------------------------------------------
    
    
    //---------------registers wire for ID to EX------------------
    reg [31:0] ID_to_EX_next_inst_pc;
    reg [31:0] ID_to_EX_inst;
    reg [31:0] ID_to_EX_readData1;
    reg [31:0] ID_to_EX_readData2;
    reg [31:0] ID_to_EX_imme;
    reg [4:0] ID_to_EX_rs;
    reg [4:0] ID_to_EX_rt;
    reg [4:0] ID_to_EX_rd;
    reg [4:0] ID_to_EX_shamt;
    reg ID_to_EX_jr;
    
    //reg [31:0] ID_to_EX_branchshift;
    
    /*control signal*/
    reg [10:0] ID_to_EX_Ctr_Signal;
    wire ID_to_EX_andi = ID_to_EX_Ctr_Signal[10];
    wire ID_to_EX_ori = ID_to_EX_Ctr_Signal[9];
    wire ID_to_EX_regDst = ID_to_EX_Ctr_Signal[8];
    wire ID_to_EX_aluSrc = ID_to_EX_Ctr_Signal[7];
    wire ID_to_EX_memToReg = ID_to_EX_Ctr_Signal[6];
    wire ID_to_EX_regWrite = ID_to_EX_Ctr_Signal[5];
    wire ID_to_EX_memRead = ID_to_EX_Ctr_Signal[4];
    wire ID_to_EX_memWrite = ID_to_EX_Ctr_Signal[3];
    wire ID_to_EX_branch = ID_to_EX_Ctr_Signal[2];
   
    wire [1:0] ID_to_EX_aluOp = ID_to_EX_Ctr_Signal[1:0];
    
    //-------------------------------------------------------------
    
    //-------------registers wire for EX to MEM--------------------------
    reg EX_to_MEM_zero;
    reg [31:0] EX_to_MEM_aluRes;
    reg [31:0] EX_to_MEM_branch_address;
    reg [31:0] EX_to_MEM_writeData;
    reg [4:0] EX_to_MEM_rt_or_rd;
    
    /*control signal*/
    reg [4:0] EX_to_MEM_Ctr_Signal;
    wire EX_to_MEM_memtoReg = EX_to_MEM_Ctr_Signal[4];
    wire EX_to_MEM_regWrite = EX_to_MEM_Ctr_Signal[3];
    wire EX_to_MEM_memRead = EX_to_MEM_Ctr_Signal[2];
    wire EX_to_MEM_memWrite = EX_to_MEM_Ctr_Signal[1];
    wire EX_to_MEM_branch = EX_to_MEM_Ctr_Signal[0];
    //-------------------------------------------------------------------
    
    
    //-------------registers wire for MEM to WB-----------------------------
    reg [31:0] MEM_to_WB_readData;
    reg [31:0] MEM_to_WB_aluRes;
    reg [4:0] MEM_to_WB_rt_or_rd;
    
    /*control signal*/
    reg [1:0] MEM_to_WB_Ctr_Signal;
    wire MEM_to_WB_memToReg = MEM_to_WB_Ctr_Signal[1];
    wire MEM_to_WB_RegWrite = MEM_to_WB_Ctr_Signal[0];
    //------------------------------------------------------------------------
    
   wire stall = ID_to_EX_memRead & (ID_to_EX_rt == IF_to_ID_rs | ID_to_EX_rt == IF_to_ID_rt);
   
    wire forward_A = (EX_to_MEM_regWrite & EX_to_MEM_rt_or_rd == ID_to_EX_rs & (EX_to_MEM_rt_or_rd!=0));
   wire forward_B = (EX_to_MEM_regWrite & EX_to_MEM_rt_or_rd == ID_to_EX_rt & (EX_to_MEM_rt_or_rd!=0));
   wire forward_C = (MEM_to_WB_RegWrite & MEM_to_WB_rt_or_rd == ID_to_EX_rs & MEM_to_WB_rt_or_rd!=0) &
   !(EX_to_MEM_regWrite & EX_to_MEM_rt_or_rd == ID_to_EX_rs & EX_to_MEM_rt_or_rd!=0);
    wire forward_D = (MEM_to_WB_RegWrite & MEM_to_WB_rt_or_rd == ID_to_EX_rt & MEM_to_WB_rt_or_rd!=0) &
   !(EX_to_MEM_regWrite & EX_to_MEM_rt_or_rd == ID_to_EX_rt & EX_to_MEM_rt_or_rd!=0);
 
     wire jump,
         jr,
         jal;
    wire andi,
          shift,
          ori;
    wire branch;
    
    wire ex_to_mem_zero;
    wire [31:0]branch_address;
    wire [31:0]jump_address = (IF_to_ID_inst[25:0]<<2) + (IF_to_ID_next_inst_pc & 32'hf0000000);
    wire [31:0] jump_address_select;
    wire [31:0] jr_address;
    wire [31:0] PC_in;
    //wire [31:0] PC_out;
    wire [31:0] PC_add_4;
    wire [31:0]PC_out;
    
     PC pc(
        .Clk(Clk),
        .stall(stall),
        .reset(reset),
        .PC_in(PC_in),
        .PC_out(PC_out)
    );
    
    //PC_add_4
    
    PC_adder_4 pc_add_4(
        .PC_add_4(PC_add_4),
        .input1(PC_out)
    );
    
    //pc select
    wire [11:0]mainCtrOut;
    wire [31:0]b_a_select;
    assign branch = EX_to_MEM_zero & EX_to_MEM_branch;
    Branch_Selector branch_pc_select(
        .input1(PC_add_4),
        .input2(EX_to_MEM_branch_address),
        .SEL(branch),
        .branch_address(b_a_select)
    );
    
    Jump_Address_selector ja_select(
        .input1(b_a_select),
        .input2(jump_address),
        .SEL(jump),
        .j_address(jump_address_select)
    );
    
    //wire [31:0]temp_PC_in
    assign jr = ID_to_EX_jr;
    jr_address_seletor jra_select(
        .input1(jump_address_select),
        .input2(jr_address),
        .SEL(jr),
        .jr_address(PC_in)
    );
    
    //instruction memory
    wire [31:0] Inst;
    InstMemory instmemory(
        .PC_out(PC_out),
        .Inst(Inst)
    );
    
    //mainCtr
    Ctr mainCtr(
        .opCode(IF_to_ID_inst[31:26]),
        .funct(IF_to_ID_inst[5:0]),
        .regDst(mainCtrOut[8]),
        .aluSrc(mainCtrOut[7]),
        .memToReg(mainCtrOut[6]),
        .regWrite(mainCtrOut[5]),
        .memRead(mainCtrOut[4]),
        .memWrite(mainCtrOut[3]),
        .branch(mainCtrOut[2]),
        .aluOp(mainCtrOut[1:0]),
        .shift(shift),
        .andi(mainCtrOut[10]),
        .ori(mainCtrOut[9]),
        .jump(jump),
        .jal(jal),
        .jr(mainCtrOut[11])
    );
    
    //Registers
    wire [31:0] reg_writeData;
    wire [31:0] reg_readData1;
    wire [31:0] reg_readData2;
    Registers regsiter(
        .readReg1(IF_to_ID_rs),
        .readReg2(IF_to_ID_rt),
        .shamt(IF_to_ID_shamt),
        .writeReg(MEM_to_WB_rt_or_rd),
        .writeData(reg_writeData),
        .regWrite(MEM_to_WB_RegWrite),
        .Clk(Clk),
        .reset(reset),
        .readData1(reg_readData1),
        .readData2(reg_readData2),
        .PC_add_4(PC_add_4),
        .jal(jal),
        .shift(shift)
    );
    
    //sign extend
    wire [31:0]immediate;
    signext ext(
        .inst(IF_to_ID_inst[15:0]),
        .data(immediate)
    );
    
    //adder
    wire [31:0] addIn2 = ID_to_EX_imme << 2;
    Adder adder(
        .input1(ID_to_EX_next_inst_pc),
        .input2(addIn2),
        .Out(branch_address)
    );
    
    //ALUCtr
    wire [3:0] aluCtrout;
    ALUCtr aluctr(
        .ALUOp(ID_to_EX_aluOp),
        .Funct(ID_to_EX_inst[5:0]),
        .ALUCtrOut(aluCtrout),
        .andi(ID_to_EX_andi),
        .ori(ID_to_EX_ori)
    );
    
    //alu input2 select
   
    //wire [31:0]alu_input2 = ID_to_EX_aluSrc? ID_to_EX_imme : ID_to_EX_readData2;
    /*ALU_input2_Selector input2_select(
        .input1(ID_to_EX_readData2),
        .input2(ID_to_EX_imme),
        .SEL(ID_to_EX_aluSrc),
        .input2_select(alu_input2)
    );*/
    
    //ALU
    wire [31:0] alu_input1 = ID_to_EX_jr ? (forward_A ? EX_to_MEM_aluRes : forward_C ? reg_writeData: ID_to_EX_readData1) : jump? ID_to_EX_imme : (forward_A ? EX_to_MEM_aluRes : forward_C ? reg_writeData : ID_to_EX_readData1);
    wire [31:0] aluRes;
    wire [31:0] alu_input2 = ID_to_EX_andi? ID_to_EX_imme: ID_to_EX_ori? ID_to_EX_imme : ID_to_EX_aluSrc ? ID_to_EX_imme : forward_B ? EX_to_MEM_aluRes : forward_D ? reg_writeData : ID_to_EX_readData2;
    
    
    assign jr_address = aluRes;
    ALU alu(
        .input1(alu_input1),
        .input2(alu_input2),
        .aluCtr(aluCtrout),
        .zero(ex_to_mem_zero),
        .aluRes(aluRes)
    );
    
    //reg destination select
    wire [4:0]ex_to_mem_rt_or_rd;
    regDst_selector reg_select(
        .input1(ID_to_EX_rt),
        .input2(ID_to_EX_rd),
        .SEL(ID_to_EX_regDst),
        .reg_select(ex_to_mem_rt_or_rd)
    );
    
    //dataMemory 
    wire [31:0]mem_to_wb_readData;
    dataMemory datamemory(
        .Clk(Clk),
        .address(EX_to_MEM_aluRes),
        .writeData(EX_to_MEM_writeData),
        .memWrite(EX_to_MEM_memWrite),
        .memRead(EX_to_MEM_memRead),
        .readData(mem_to_wb_readData)
    );
    
    //writeData select
    /*writeData_Selector writeData_select(
        .input1(MEM_to_WB_aluRes),
        .input2(MEM_to_WB_readData),
        .SEL(MEM_to_WB_memToReg),
        .writeData_select(reg_writeData)
    );*/
    assign reg_writeData = MEM_to_WB_memToReg ? MEM_to_WB_readData : MEM_to_WB_aluRes;
    wire mem_writeData = forward_B ? EX_to_MEM_aluRes : forward_D ? reg_writeData : ID_to_EX_readData2;
    
    always @ (posedge Clk) begin
        MEM_to_WB_Ctr_Signal <= EX_to_MEM_Ctr_Signal[4:3];
        MEM_to_WB_rt_or_rd <= EX_to_MEM_rt_or_rd;
        MEM_to_WB_aluRes <= EX_to_MEM_aluRes;
        MEM_to_WB_readData <= mem_to_wb_readData;
        
        EX_to_MEM_Ctr_Signal <= ID_to_EX_Ctr_Signal[6:2];
        EX_to_MEM_rt_or_rd <= ex_to_mem_rt_or_rd;
        EX_to_MEM_writeData <= mem_writeData;
        EX_to_MEM_aluRes <= aluRes;
        EX_to_MEM_branch_address <= branch_address;
        EX_to_MEM_zero <= ex_to_mem_zero;
        
        if(!stall & !branch & !jr) begin
        ID_to_EX_Ctr_Signal <= mainCtrOut[10:0];
        ID_to_EX_next_inst_pc <= IF_to_ID_next_inst_pc;
        ID_to_EX_inst <= IF_to_ID_inst;
        ID_to_EX_readData1 <= reg_readData1;
        ID_to_EX_readData2 <= reg_readData2;
        ID_to_EX_imme <= immediate ;
        ID_to_EX_rs <= IF_to_ID_rs;
        ID_to_EX_rt <= IF_to_ID_rt;
        ID_to_EX_rd <= IF_to_ID_rd;
        ID_to_EX_shamt <= IF_to_ID_shamt;
        ID_to_EX_jr <= mainCtrOut[11];
        $display("next");
        end
        else begin
        ID_to_EX_Ctr_Signal <= 0;
        ID_to_EX_next_inst_pc <= 0;
        ID_to_EX_inst <= 0;
        ID_to_EX_readData1 <= 0;
        ID_to_EX_readData2 <= 0;
        ID_to_EX_imme <= 0;
        ID_to_EX_rs <= 0;
        ID_to_EX_rt <= 0;
        ID_to_EX_rd <= 0;
        ID_to_EX_shamt <= 0;
        ID_to_EX_jr <= 0;
        end
        
        if(!stall & !branch & !jump & !jr) begin
            IF_to_ID_next_inst_pc <= PC_add_4;
            IF_to_ID_inst <= Inst;
        end
        
        if(jump | branch | jr) begin
            IF_to_ID_inst <= 0;
            IF_to_ID_next_inst_pc <= 0;
        end
        
        
    end
endmodule
