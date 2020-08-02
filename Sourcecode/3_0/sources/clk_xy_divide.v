`timescale 1ns / 1ps
//y
module clk_xy_divide(
        input clk,
        input x,
        input y,
        
        input [10:0]left,
        input [10:0]right,
        input [9:0]top,
        input [9:0]bottom,
        
        output clk_1,
        output reg [10:0]left1,
        output reg [10:0]right1,
        output reg [9:0]top1,
        output reg [9:0]bottom1,
        
        
        output clk_2,
        output reg [10:0]left2,
        output reg [10:0]right2,
        output reg [9:0]top2,
        output reg [9:0]bottom2,
        
        
        output clk_3,
        output reg [10:0]left3,
        output reg [10:0]right3,
        output reg [9:0]top3,
        output reg [9:0]bottom3
    );
    parameter l=11'd220;
    parameter r=11'd1060;
    parameter t=11'd210;
    parameter b=11'd510;
    
    parameter P_3_10=6'd19;
    parameter P_7_10=6'd45;
    
    reg [23:0]x1;
    reg [23:0]x2;
    reg [23:0]x3;
    reg [23:0]x4;
    
    reg c[2:0];
    
    assign clk_1=c[0]?clk:1'b0;
    assign clk_2=c[1]?clk:1'b0;
    assign clk_3=c[2]?clk:1'b0;
    //边框划分
    always@(left or right or top or bottom)
    begin
    x1={12'b0,left};
    x2={12'b0,right};
    x3=(x2*P_3_10+x1*P_7_10)>>6;
    x4=(x2*P_7_10+x1*P_3_10)>>6;
    
    left1=left;
    
    right1=x3[10:0];
    left2=x3[10:0];
    
    right2=x4[10:0];
    left3=x4[10:0];
    
    right3=right;
    
    
    top1=top;
    top2=top;
    top3=top;
    
    bottom1=bottom;
    bottom2=bottom;
    bottom3=bottom;
    
    end
    //时钟分发
    always@(clk)
    begin
    
    if(x<l||x>r||y>b||y<t)
        begin
        c[0]<=1;
        c[1]<=1;
        c[2]<=1;
        end
    else if(y>top1&&y<bottom1&&x>left1&&x<right1)
        c[0]<=1;
    else if(y>top2&&y<bottom2&&x>left2&&x<right2)
        c[1]<=1;
    else if(y>top3&&y<bottom3&&x>=left3&&x<right3)
        c[2]<=1;
    else
        begin
        c[0]<=0;
        c[1]<=0;
        c[2]<=0;
        end
    end
    
    
endmodule
