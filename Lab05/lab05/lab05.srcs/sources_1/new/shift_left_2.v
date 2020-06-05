`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/30 15:49:03
// Design Name: 
// Module Name: shift_26_to_28
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


module shift_26_to_28(
    input [25:0]Inst,
    output reg [27:0] shift_data
    );
    
    always @ (Inst)
    begin
        shift_data[25:0] = Inst[25:0];
        shift_data = shift_data<<2;
    end
 endmodule
