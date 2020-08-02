`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 00:44:01
// Design Name: 
// Module Name: videoshow
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


module videoshow(
    input clk,
    input [23:0]RGB_Data_Src, 
    input RGB_HSync_Src, 
    input RGB_VSync_Src, 
    input RGB_VDE_Src,
    
    input [10:0]RGB_x_Src,
    input [9:0]RGB_y_Src,
    
    input [10:0]left,
    input [10:0]right,
    input [9:0]top,
    input [9:0]bottom,
    
    input [3:0]num,
    
    output reg [23:0]RGB_Data,
     
    output RGB_HSync, 
    output RGB_VSync,
    output RGB_VDE 
    );
                
    parameter left_=11'd440;
    parameter right_=11'd840;
    parameter top_=10'd120;
    parameter bottom_=10'd600;
    
    parameter x1=11'd1170;
    parameter x2=11'd1240;
    parameter y1=10'd5;
    parameter y2=10'd71;
    parameter y3=10'd145;
    parameter d=4'd8;
    
    
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
    
    reg [12:0]numshow=numnone;
    
    always@(*)
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
    
    assign RGB_HSync=RGB_HSync_Src;
    assign RGB_VSync=RGB_VSync_Src;
    assign RGB_VDE=RGB_VDE_Src;
    
always@(*)
    begin
        //if(RGB_x_Src==640)
            //RGB_Data<={16'b0,8'd255};
        //else if((RGB_y_Src==330)||(RGB_y_Src==410))
            //RGB_Data<={16'b0,8'd255};
        if (((RGB_y_Src==bottom)||(RGB_y_Src==top))&&(RGB_x_Src>=left)&&(RGB_x_Src<=right))
            RGB_Data<={8'd255,16'b0};
        else if (((RGB_x_Src==left)||(RGB_x_Src==right))&&(RGB_y_Src>=top)&&(RGB_y_Src<=bottom))
            RGB_Data<={8'd255,16'b0};
        
        else if (((RGB_y_Src==bottom_)||(RGB_y_Src==top_))&&(RGB_x_Src>=left_)&&(RGB_x_Src<=right_))
            RGB_Data<={8'b0,8'd255,8'b0};
        else if (((RGB_x_Src==left_)||(RGB_x_Src==right_))&&(RGB_y_Src>=top_)&&(RGB_y_Src<=bottom_))
            RGB_Data<={8'b0,8'd255,8'b0};  
            
            
            
            
        else if((RGB_x_Src>=1130)&&(RGB_y_Src<=150))
                begin
                if((RGB_x_Src>=(x1+d))&&((RGB_x_Src<=(x2-d)))&&(RGB_y_Src>=(y1))&&(RGB_y_Src<=(y1+d)))
                begin
                    if(numshow[12])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //2
                else if((RGB_x_Src>=(x2-d))&&((RGB_x_Src<=(x2)))&&(RGB_y_Src>=(y1+d))&&(RGB_y_Src<=(y2)))
                begin
                    if(numshow[11])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //3
                else if((RGB_x_Src>=(x2-d))&&((RGB_x_Src<=(x2)))&&(RGB_y_Src>=(y2+d))&&(RGB_y_Src<=(y3-d)))
                begin
                    if(numshow[10])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //4
                else if((RGB_x_Src>=(x1+d))&&((RGB_x_Src<=(x2-d)))&&(RGB_y_Src>=(y3-d))&&(RGB_y_Src<=(y3)))
                begin
                    if(numshow[9])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //5
                else if((RGB_x_Src>=(x1))&&((RGB_x_Src<=(x1+d)))&&(RGB_y_Src>=(y2+d))&&(RGB_y_Src<=(y3-d)))
                begin
                    if(numshow[8])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //6
                else if((RGB_x_Src>=(x1))&&((RGB_x_Src<=(x1+d)))&&(RGB_y_Src>=(y1+d))&&(RGB_y_Src<=(y2)))
                begin
                    if(numshow[7])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //7
                else if((RGB_x_Src>=(x1+d))&&((RGB_x_Src<=(x2-d)))&&(RGB_y_Src>=(y2))&&(RGB_y_Src<=(y2+d)))
                begin
                    if(numshow[6])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //a
                else if((RGB_x_Src>(x1))&&((RGB_x_Src<(x1+d)))&&(RGB_y_Src>(y1))&&(RGB_y_Src<(y1+d)))
                begin
                    if(numshow[5])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //b
                else if((RGB_x_Src>(x2-d))&&((RGB_x_Src<(x2)))&&(RGB_y_Src>(y1))&&(RGB_y_Src<(y1+d)))
                begin
                    if(numshow[4])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //c
                else if((RGB_x_Src>(x2-d))&&((RGB_x_Src<(x2)))&&(RGB_y_Src>(y2))&&(RGB_y_Src<(y2+d)))
                begin
                    if(numshow[3])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //d
                else if((RGB_x_Src>(x2-d))&&((RGB_x_Src<(x2)))&&(RGB_y_Src>(y3-d))&&(RGB_y_Src<(y3)))
                begin
                    if(numshow[2])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //e
                else if((RGB_x_Src>(x1))&&((RGB_x_Src<(x1+d)))&&(RGB_y_Src>(y3-d))&&(RGB_y_Src<(y3)))
                begin
                    if(numshow[1])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //f
                else if((RGB_x_Src>(x1))&&((RGB_x_Src<(x1+d)))&&(RGB_y_Src>(y2))&&(RGB_y_Src<(y2+d)))
                begin
                    if(numshow[0])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                else
                        RGB_Data<=24'd16777215;
                end
        else
            RGB_Data<=RGB_Data_Src;
        
    end

endmodule