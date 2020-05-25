`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 07:57:30
// Design Name: 
// Module Name: flowing_light
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

module flowing_light(
    input clock,
    input reset,
    output [7:0] led
    );
    
    //initial defination
    //if quicker to light the second led, use following 
    //reg[4:0] cnt_reg
    reg[24:0] cnt_reg;
    reg[7 : 0] light_reg;
    
    always @ (posedge clock)
        begin
            if (reset)
                cnt_reg <= 0;
            else
                cnt_reg <= cnt_reg + 1;
        end
        
    always @ (posedge clock)
        begin
            if (reset)
                light_reg <= 8'h01;
            //if quicker to light the second led, use following 
            //else if (cnt_reg == 4'hf)
            else if (cnt_reg == 24'hffffff)
                begin
                    if (light_reg == 8'h80)
                        light_reg <= 8'h01;
                    else
                        light_reg <= light_reg << 1;
                end
        end
    assign led = light_reg;
endmodule
