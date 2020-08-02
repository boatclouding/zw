`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 11:27:01
// Design Name: 
// Module Name: numdecode
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


module numdecode(
    input clk,
    input [3:0]num,
    output reg [12:0]numshow
    );
    
    parameter num0=13'b1111110111111;
    parameter num1=13'b0110000011100;
    parameter num2=13'b1101101111111;
    parameter num3=13'b1111001111111;
    parameter num4=13'b0110011111101;
    parameter num5=13'b1011011111111;
    parameter num6=13'b1011111111111;
    parameter num7=13'b1110000111100;
    parameter num8=13'b1111111111111;
    parameter num9=13'b1111011111111;
    parameter numnone=13'b0000000000000;
    
    
    
    
    always@(posedge clk)
    begin
    if(num==4'd0)
        numshow<=num0;
    else if(num==4'd1)
        numshow<=num1;
    else if(num==4'd2)
        numshow<=num2;
    else if(num==4'd3)
        numshow<=num3;
    else if(num==4'd4)
        numshow<=num4;
    else if(num==4'd5)
        numshow<=num5;
    else if(num==4'd6)
        numshow<=num6;
    else if(num==4'd7)
        numshow<=num7;
    else if(num==4'd8)
        numshow<=num8;
    else if(num==4'd9)
        numshow<=num9;
    else
        numshow<=numnone;
    end
    
endmodule
