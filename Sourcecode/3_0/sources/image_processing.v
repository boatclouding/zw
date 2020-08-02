`timescale 1ns / 1ps
//y

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
    
    //测试用
    output [10:0]x_1_4,
    output [10:0]x_3_4,
    
    output [10:0]left1,
    output [10:0]right1,
    output [9:0]top1,
    output [9:0]bottom1,
    
    output [10:0]left2,
    output [10:0]right2,
    output [9:0]top2,
    output [9:0]bottom2,
    
    output [10:0]left3,
    output [10:0]right3,
    output [9:0]top3,
    output [9:0]bottom3,
    
    output [3:0]num1,
    output [3:0]num2,
    output [3:0]num3
    
    );
    wire clk1;
    wire clk2;
    wire clk3;
    
    
    wire [10:0]l1;
    wire [10:0]r1;
    wire [9:0]t1;
    wire [9:0]b1;
    
    wire [10:0]l2;
    wire [10:0]r2;
    wire [9:0]t2;
    wire [9:0]b2;
    
    wire [10:0]l3;
    wire [10:0]r3;
    wire [9:0]t3;
    wire [9:0]b3;
    
    //算式边界检测
    edge_track edge_track0(
        .clk(clk),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src), 
        
        //检测范围
        .left_boundary(11'd220),
        .right_boundary(11'd1060),
        .top_boundary(10'd210),
        .bottom_boundary(10'd510),
        
        //输出边界
        .Left(left),
        .Right(right),
        .Top(top),
        .Bottom(bottom)
        
        );
        
       assign x_1_4=l2;
       assign x_3_4=r2;
       
     clk_xy_divide cd(
        .clk(clk),
        .x(RGB_x_Src),
        .y(RGB_y_Src),
        
        //第一帧获得的算式边界
        
        //.left(left),
        //.right(left),
        //.top(left),
        //.bottom(left),
        
        .left(left),
        .right(right),
        .top(top),
        .bottom(bottom),
        //分析第一帧，输出第二帧的时钟及边界检测范围
        .clk_1(clk1),
        .left1(l1),
        .right1(r1),
        .top1(t1),
        .bottom1(b1),
        
        
        .clk_2(clk2),
        .left2(l2),
        .right2(r2),
        .top2(t2),
        .bottom2(b2),
        
        
        .clk_3(clk3),
        .left3(l3),
        .right3(r3),
        .top3(t3),
        .bottom3(b3)
    );
    
    //算式最左边界检测，第二帧扫描完得出结果
    edge_track edge_track1(
        .clk(clk1),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src), 
        
        //检测范围
        .left_boundary(l1),
        .right_boundary(r1),
        .top_boundary(t1),
        .bottom_boundary(b1),
        
        //输出边界
        .Left(left1),
        .Right(right1),
        .Top(top1),
        .Bottom(bottom1)
        
        );
        
    //算式中部边界界检测，第二帧扫描完得出结果
        edge_track edge_track2(
        .clk(clk2),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src), 
        
        //检测范围
        .left_boundary(l2),
        .right_boundary(r2),
        .top_boundary(t2),
        .bottom_boundary(b2),
        
        //输出边界
        .Left(left2),
        .Right(right2),
        .Top(top2),
        .Bottom(bottom2)
        
        ); 
        
        
    //算式最右边界检测，第二帧扫描完得出结果
        edge_track edge_track3(
        .clk(clk3),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src), 
        
        //检测范围
        .left_boundary(l3),
        .right_boundary(r3),
        .top_boundary(t3),
        .bottom_boundary(b3),
        
        //输出边界
        .Left(left3),
        .Right(right3),
        .Top(top3),
        .Bottom(bottom3)
        
        );     
          //数字识别
    digital_recognition digital_recognition1(
        .clk(clk),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src),
        
        .left(left1),
        .right(right1),
        .top(top1),
        .bottom(bottom1),
        
        .tag(1'b0),    
        .num(num1)
        );
        //数字识别，第三帧得结果
        digital_recognition digital_recognition2(
        .clk(clk),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src),
        
        .left(left2),
        .right(right2),
        .top(top2),
        .bottom(bottom2),
        
        .tag(1'b1),    
        .num(num2)
        );
        digital_recognition digital_recognition3(
        .clk(clk),
        .RGB_Data_Src(RGB_Data_Src), 
        .RGB_x_Src(RGB_x_Src),
        .RGB_y_Src(RGB_y_Src),
        
        .left(left3),
        .right(right3),
        .top(top3),
        .bottom(bottom3),
        
        .tag(1'b0),    
        .num(num3)
        );
    
        
  
endmodule
