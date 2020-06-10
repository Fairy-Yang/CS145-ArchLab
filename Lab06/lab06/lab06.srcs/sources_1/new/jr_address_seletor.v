`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 15:15:59
// Design Name: 
// Module Name: jr_address_seletor
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


module jr_address_seletor(
    input [31:0] input1,
    input [31:0] input2,
    input SEL,
    output reg [31:0] jr_address
    );
    
    initial begin
        jr_address = 0;
    end
    
    always @ (input1 or input2 or SEL)
        assign jr_address = SEL? input2:input1;
endmodule
