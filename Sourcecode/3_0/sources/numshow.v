`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 11:37:02
// Design Name: 
// Module Name: numshow
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


module numshow (
    input clk,
    input [12:0]numshow1,
    
    
    input [10:0]l,
    input [9:0]t,
    
    input [10:0]RGB_x_Src,
    input [9:0]RGB_y_Src,
    
    output reg [23:0]RGB_Data
    );
    
    parameter width=11'd70;
    parameter high=10'd140;
    parameter m_t=10'd66;
    parameter d=4'd8;
    parameter L1=11'd150;//±ß³¤
    parameter L2=10'd150;//±ß³¤
    
    
    reg [10:0]x1;
    reg [10:0]x2;
    reg [9:0]y1;
    reg [9:0]y2;
    reg [9:0]y3;
    
    reg [10:0]b;
    reg [9:0]r;
    
    
    always@(posedge clk)
    if(RGB_x_Src==11'd100&&RGB_y_Src==10'd1)
    begin
        x1<=l+11'd40;
        y1<=t+10'd5;
        x2<=l+width+11'd40;
        y2<=t+m_t+10'd5;
        y3<=t+high+10'd5;
        r<=l+L1;
        b<=t+L2;
    end
    
    
    
    always@(posedge clk)
    begin
        if((RGB_x_Src>=l)&&(RGB_x_Src<=r)&&(RGB_y_Src>=t)&&(RGB_y_Src<=b))
                begin
                if((RGB_x_Src>=(x1+d))&&((RGB_x_Src<=(x2-d)))&&(RGB_y_Src>=(y1))&&(RGB_y_Src<=(y1+d)))
                begin
                    if(numshow1[12])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //2
                else if((RGB_x_Src>=(x2-d))&&((RGB_x_Src<=(x2)))&&(RGB_y_Src>=(y1+d))&&(RGB_y_Src<=(y2)))
                begin
                    if(numshow1[11])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //3
                else if((RGB_x_Src>=(x2-d))&&((RGB_x_Src<=(x2)))&&(RGB_y_Src>=(y2+d))&&(RGB_y_Src<=(y3-d)))
                begin
                    if(numshow1[10])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //4
                else if((RGB_x_Src>=(x1+d))&&((RGB_x_Src<=(x2-d)))&&(RGB_y_Src>=(y3-d))&&(RGB_y_Src<=(y3)))
                begin
                    if(numshow1[9])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //5
                else if((RGB_x_Src>=(x1))&&((RGB_x_Src<=(x1+d)))&&(RGB_y_Src>=(y2+d))&&(RGB_y_Src<=(y3-d)))
                begin
                    if(numshow1[8])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //6
                else if((RGB_x_Src>=(x1))&&((RGB_x_Src<=(x1+d)))&&(RGB_y_Src>=(y1+d))&&(RGB_y_Src<=(y2)))
                begin
                    if(numshow1[7])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //7
                else if((RGB_x_Src>=(x1+d))&&((RGB_x_Src<=(x2-d)))&&(RGB_y_Src>=(y2))&&(RGB_y_Src<=(y2+d)))
                begin
                    if(numshow1[6])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //a
                else if((RGB_x_Src>(x1))&&((RGB_x_Src<(x1+d)))&&(RGB_y_Src>(y1))&&(RGB_y_Src<(y1+d)))
                begin
                    if(numshow1[5])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //b
                else if((RGB_x_Src>(x2-d))&&((RGB_x_Src<(x2)))&&(RGB_y_Src>(y1))&&(RGB_y_Src<(y1+d)))
                begin
                    if(numshow1[4])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //c
                else if((RGB_x_Src>(x2-d))&&((RGB_x_Src<(x2)))&&(RGB_y_Src>(y2))&&(RGB_y_Src<(y2+d)))
                begin
                    if(numshow1[3])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //d
                else if((RGB_x_Src>(x2-d))&&((RGB_x_Src<(x2)))&&(RGB_y_Src>(y3-d))&&(RGB_y_Src<(y3)))
                begin
                    if(numshow1[2])
                        RGB_Data<={8'd1,8'd1,8'd1};
                    else
                        RGB_Data<=24'd16777215;
                end
                //e
                else if((RGB_x_Src>(x1))&&((RGB_x_Src<(x1+d)))&&(RGB_y_Src>(y3-d))&&(RGB_y_Src<(y3)))
                begin
                    if(numshow1[1])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                //f
                else if((RGB_x_Src>(x1))&&((RGB_x_Src<(x1+d)))&&(RGB_y_Src>(y2))&&(RGB_y_Src<(y2+d)))
                begin
                    if(numshow1[0])
                        RGB_Data<=24'd0;
                    else
                        RGB_Data<=24'd16777215;
                end
                else
                        RGB_Data<=24'd16777215;
                end
        else
            RGB_Data<=24'd0;
    end
endmodule
