`timescale 1ns / 1ps
module image_processing(
    input clk,
    input [23:0]RGB_Data_Src, 
    input RGB_HSync_Src, 
    input RGB_VSync_Src, 
    input RGB_VDE_Src,
    input [10:0]RGB_x_Src,
    input [9:0]RGB_y_Src,
    
    output [10:0]left,
    output [10:0]right,
    output [9:0]top,
    output [9:0]bottom,
    output [3:0]num
    );
    
    //边界检测
    edge_track edge_track1(
        .clk(clk),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src),        
        .Left(left),
        .Right(right),
        .Top(top),
        .Bottom(bottom)
        );
    
    //数字识别
    digital_recognition digital_recognition1(
        .clk(clk),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src),
        .left(left),
        .right(right),
        .top(top),
        .bottom(bottom),    
        .num(num)
        );
    
endmodule
