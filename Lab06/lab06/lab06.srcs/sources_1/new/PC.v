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
    input stall,
    input [31:0] PC_in,
    output reg [31:0] PC_out,
    input reset
    );
    reg [31:0]lastPC;
    
    always @ (posedge Clk or reset)
    begin
        if(reset == 1)begin
            lastPC = 0;
            PC_out = 0;
       end
       if(!stall) begin
            PC_out = PC_in;
            lastPC = PC_in;
      end
      else begin
            PC_out = lastPC;
            $display("stall");
       end
    end

endmodule