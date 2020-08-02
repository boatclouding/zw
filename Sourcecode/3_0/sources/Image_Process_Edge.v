`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 14:06:35
// Design Name: 
// Module Name: Image_Process_Edge
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


module Image_Process( 
    input clk_Image_Process, 
    input Rst,
     
    input [23:0]RGB_Data_Src, 
    input RGB_HSync_Src, 
    input RGB_VSync_Src, 
    input RGB_VDE_Src,
    input [10:0]RGB_x_Src,
    input [9:0]RGB_y_Src,
     
    output [23:0]RGB_Data, 
    output RGB_HSync, 
    output RGB_VSync,
    output RGB_VDE 
    ); 
    //RGB ���ݻҶȻ��ľ��� 
    parameter RGB2Gray_Accuracy_N=8; 
    //��,��,������Ч�ź���ʱ���� 
    wire [4:0]Delay_Num=0; 
    //�Ҷ����� 
    wire [7:0]Gray_Data;
    //2ֵ������
    wire [7:0]BW_Data; 
    //�����ͼ������ 
    
    wire [23:0]RGB_Data_Out; 
    //ͼ��2ֵ���������
    wire [23:0]RGB_Data_Out_BW;
    //�߽�ֵ
    wire [10:0]left;
    wire [10:0]right;
    wire [9:0]top;
    wire [9:0]bottom;
    
    
    wire [10:0]left1;
    wire [10:0]right1;
    wire [9:0]top1;
    wire [9:0]bottom1;
    
    wire [10:0]left2;
    wire [10:0]right2;
    wire [9:0]top2;
    wire [9:0]bottom2;
    
    wire [10:0]left3;
    wire [10:0]right3;
    wire [9:0]top3;
    wire [9:0]bottom3;
    
    //ʶ����������
    
    wire [3:0]num1;
    wire [3:0]num2;
    wire [3:0]num3;
    
    wire [3:0]num1_;
    wire [3:0]num2_;
    wire [3:0]num3_;
    wire [3:0]num4_;
    wire [3:0]char;
    
    
    wire [10:0]x_1_4;
    wire [10:0]x_3_4;
    
    //ͼ��ҶȻ� 
    RGB_To_Gray_0 RGB2Gray( 
        .RGB_Data_R(RGB_Data_Src[23:16]),              //�������� R 
        .RGB_Data_G(RGB_Data_Src[15:8]),               //�������� G 
        .RGB_Data_B(RGB_Data_Src[7:0]),                //�������� B 
        .Accuracy_Num(RGB2Gray_Accuracy_N),            //�ҶȻ�����λ�� 
        .Gray_Data(Gray_Data)                          //����Ҷ����� 
        );
        
    //ͼ��2ֵ��
    assign BW_Data=(Gray_Data>40)?(8'd255):(8'd0);
    assign RGB_Data=RGB_Data_Out; 
    assign RGB_Data_Out_BW={BW_Data,BW_Data,BW_Data};
    //ͼ����
   
   
    image_processing image_processing1(
   
    .clk(clk_Image_Process),
    .RGB_Data_Src(RGB_Data_Out_BW), 
    .RGB_HSync_Src(RGB_HSync_Src), 
    .RGB_VSync_Src(RGB_VSync_Src), 
    .RGB_VDE_Src(RGB_VDE_Src),
    .RGB_x_Src(RGB_x_Src),
    .RGB_y_Src(RGB_y_Src),
    
    .left(left),
    .right(right),
    .top(top),
    .bottom(bottom),
    
    //������
    .x_1_4(x_1_4),
    .x_3_4(x_3_4),
    
    .left1(left1),
    .right1(right1),
    .top1(top1),
    .bottom1(bottom1),
    
    .left2(left2),
    .right2(right2),
    .top2(top2),
    .bottom2(bottom2),
    
    .left3(left3),
    .right3(right3),
    .top3(top3),
    .bottom3(bottom3),
    
    .num1(num1),
    .num2(num2),
    .num3(num3)
    );
   calculate c1(
    .clk(clk_Image_Process),
    .i_num1(num1),//��һ����
    .i_num2(num3),//�ڶ�����
    .operation(num2),//�����
    .o_num1(num1_),
    .o_num2(num2_),
    .char(char),
    .shiwei(num3_),
    .gewei(num4_)
    );

    
    //ͼ�����
    videoshow videoshow1(
    .clk(clk_Image_Process),
    .RGB_Data_Src(RGB_Data_Out_BW), 
    .RGB_HSync_Src(RGB_HSync_Src), 
    .RGB_VSync_Src(RGB_VSync_Src), 
    .RGB_VDE_Src(RGB_VDE_Src),
    .RGB_x_Src(RGB_x_Src),
    .RGB_y_Src(RGB_y_Src),
    
    
    //�ĸ����
    .left(left),
    .right(right),
    .top(top),
    .bottom(bottom),
    
    //������
    .x_1_4(x_1_4),
    .x_3_4(x_3_4),
    
    .left1(left1),
    .right1(right1),
    .top1(top1),
    .bottom1(bottom1),
    
    .left2(left2),
    .right2(right2),
    .top2(top2),
    .bottom2(bottom2),
    
    .left3(left3),
    .right3(right3),
    .top3(top3),
    .bottom3(bottom3),
    
    
    .num1(num1_),
    .num2(num2_),
    .num3(num3_),
    .num4(num4_),
    .char1(char),
    .char2(4'd10),
    
    .RGB_Data_all(RGB_Data_Out), 
    
    .RGB_HSync(RGB_HSync), 
    .RGB_VSync(RGB_VSync),
    .RGB_VDE(RGB_VDE) 
    
    );
    
endmodule 