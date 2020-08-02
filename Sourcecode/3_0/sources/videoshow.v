`timescale 1ns / 1ps
//y
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
    
    input [10:0]x_1_4,
    input [10:0]x_3_4,
    
    input [10:0]left1,
    input [10:0]right1,
    input [9:0]top1,
    input [9:0]bottom1,
    
    
    input [10:0]left2,
    input [10:0]right2,
    input [9:0]top2,
    input [9:0]bottom2,
    
    input [10:0]left3,
    input [10:0]right3,
    input [9:0]top3,
    input [9:0]bottom3,
    
    
    input [3:0]num1,
    input [3:0]num2,
    input [3:0]num3,
    input [3:0]num4,
    input [3:0]char1,
    input [3:0]char2,
    
    
    output  reg [23:0]RGB_Data_all,
     
    output RGB_HSync, 
    output RGB_VSync,
    output RGB_VDE 
    );
    
    wire [23:0]rgb_data_n1;
    wire [23:0]rgb_data_n2;
    wire [23:0]rgb_data_n3;
    wire [23:0]rgb_data_n4;
    wire [23:0]rgb_data_n5;
    wire [23:0]rgb_data_n6;
    
    
    reg [23:0]RGB_Data;
    
    wire [12:0]dn1;
    wire [12:0]dn2;
    wire [12:0]dn4;
    wire [12:0]dn6;
                
    parameter left_=11'd220;
    parameter right_=11'd1060;
    parameter top_=10'd210;
    parameter bottom_=10'd510;
    
    parameter l1=11'd1130;
    //parameter r1=11'd1280;
    parameter t1=10'd2;
    //parameter b1=10'd152;
    
    
    parameter l2=11'd980;
    //parameter r2=11'd1130;
    parameter t2=10'd2;
    //parameter b2=10'd152;
    
    parameter l3=11'd830;
    //parameter r3=11'd980;
    parameter t3=10'd2;
    //parameter b3=10'd152;
    
    parameter l4=11'd680;
    //parameter r4=11'd830;
    parameter t4=10'd2;
    //parameter b4=10'd152;
    
    parameter l5=11'd530;
    //parameter r5=11'd680;
    parameter t5=10'd2;
    //parameter b5=10'd152;
    
    parameter l6=11'd380;
    //parameter r6=11'd530;
    parameter t6=10'd2;
    //parameter b6=10'd152;
    
    always@(posedge clk)
    begin
    if(rgb_data_n4!=0)
        RGB_Data_all<=rgb_data_n4;
    else if(rgb_data_n6!=0)
        RGB_Data_all<=rgb_data_n6;
    else if(rgb_data_n1!=0)
        RGB_Data_all<=rgb_data_n1;
    else if(rgb_data_n2!=0)
        RGB_Data_all<=rgb_data_n2;
    else
        RGB_Data_all<=RGB_Data;
    end
    
    numdecode nd1(
        .clk(RGB_HSync),
        .num(num4),
        .numshow(dn1)
    );
    
    
    numdecode nd2(
        .clk(RGB_HSync),
        .num(num3),
        .numshow(dn2)
    );
    numdecode nd4(
        .clk(RGB_HSync),
        .num(num2),
        .numshow(dn4)
    );
    
    numdecode nd6(
        .clk(RGB_HSync),
        .num(num1),
        .numshow(dn6)
    );
    
    numshow ns1(
    .clk(clk),
    .numshow1(dn1),
    .l(l1),
    .t(t1),
    .RGB_x_Src(RGB_x_Src),
    .RGB_y_Src(RGB_y_Src),
    .RGB_Data(rgb_data_n1)
    );
    numshow ns2(
    .clk(clk),
    .numshow1(dn2),
    .l(l2),
    .t(t2),
    .RGB_x_Src(RGB_x_Src),
    .RGB_y_Src(RGB_y_Src),
    .RGB_Data(rgb_data_n2)
    );
    numshow ns4(
    .clk(clk),
    .numshow1(dn4),
    .l(l4),
    .t(t4),
    .RGB_x_Src(RGB_x_Src),
    .RGB_y_Src(RGB_y_Src),
    .RGB_Data(rgb_data_n4)
    );
    numshow ns6(
    .clk(clk),
    .numshow1(dn6),
    .l(l6),
    .t(t6),
    .RGB_x_Src(RGB_x_Src),
    .RGB_y_Src(RGB_y_Src),
    .RGB_Data(rgb_data_n6)
    );
    
    assign RGB_HSync=RGB_HSync_Src;
    assign RGB_VSync=RGB_VSync_Src;
    assign RGB_VDE=RGB_VDE_Src;
    
always@(*)
    begin
        //×ó±ß¿ò 
        if (((RGB_y_Src==bottom1)||(RGB_y_Src==top1))&&(RGB_x_Src>=left1)&&(RGB_x_Src<=right1))
            RGB_Data={16'b0,8'd255};
        else if (((RGB_x_Src==left1)||(RGB_x_Src==right1))&&(RGB_y_Src>=top1)&&(RGB_y_Src<=bottom1))
            RGB_Data={16'b0,8'd255};
        //ÖÐ±ß¿ò    
        else if (((RGB_y_Src==bottom2)||(RGB_y_Src==top2))&&(RGB_x_Src>=left2)&&(RGB_x_Src<=right2))
            RGB_Data={16'b0,8'd255};
        else if (((RGB_x_Src==left2)||(RGB_x_Src==right2))&&(RGB_y_Src>=top2)&&(RGB_y_Src<=bottom2))
            RGB_Data={16'b0,8'd255};
         //ÓÒ±ß¿ò   
        else if (((RGB_y_Src==bottom3)||(RGB_y_Src==top3))&&(RGB_x_Src>=left3)&&(RGB_x_Src<=right3))
            RGB_Data={16'b0,8'd255};
        else if (((RGB_x_Src==left3)||(RGB_x_Src==right3))&&(RGB_y_Src>=top3)&&(RGB_y_Src<=bottom3))
            RGB_Data={16'b0,8'd255};
        //ÏÞ¶¨¿ò
        else if (((RGB_y_Src==bottom_)||(RGB_y_Src==top_))&&(RGB_x_Src>=left_)&&(RGB_x_Src<=right_))
            RGB_Data={8'b0,8'd255,8'b0};
        else if (((RGB_x_Src==left_)||(RGB_x_Src==right_))&&(RGB_y_Src>=top_)&&(RGB_y_Src<=bottom_))
            RGB_Data={8'b0,8'd255,8'b0};  
        //ËãÊ½¿ò
        else if (((RGB_y_Src==bottom)||(RGB_y_Src==top))&&(RGB_x_Src>=left)&&(RGB_x_Src<=right))
            RGB_Data={8'd255,16'b0};
        else if ((((RGB_x_Src==left)||(RGB_x_Src==right))||((RGB_x_Src==x_1_4)||(RGB_x_Src==x_3_4)))&&(RGB_y_Src>=top)&&(RGB_y_Src<=bottom))
            RGB_Data={8'd255,16'b0};
        else
            RGB_Data=RGB_Data_Src;   
    end
endmodule