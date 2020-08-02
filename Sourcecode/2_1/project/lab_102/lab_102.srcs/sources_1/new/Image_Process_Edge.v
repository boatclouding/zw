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
    reg [23:0]RGB_Data_Out; 
    //ͼ��2ֵ���������
    wire [23:0]RGB_Data_Out_BW;
    //�߽�ֵ
    wire [10:0]left;
    wire [10:0]right;
    wire [9:0]top;
    wire [9:0]bottom;
    
    //ʶ����������
    wire [3:0]num;
    
    //ͼ��ҶȻ� 
    RGB_To_Gray_0 RGB2Gray( 
        .RGB_Data_R(RGB_Data_Src[23:16]),              //�������� R 
        .RGB_Data_G(RGB_Data_Src[15:8]),               //�������� G 
        .RGB_Data_B(RGB_Data_Src[7:0]),                //�������� B 
        .Accuracy_Num(RGB2Gray_Accuracy_N),            //�ҶȻ�����λ�� 
        .Gray_Data(Gray_Data)                          //����Ҷ����� 
        );
    //ͼ��2ֵ��
    assign BW_Data=(Gray_Data>60)?(8'd255):(8'd0);
    assign RGB_Data=RGB_Data_Out; 
    assign RGB_Data_Out_BW={BW_Data,BW_Data,BW_Data};
    //ͼ����
   
   
    image_processing image_processing1(
   
    .clk(clk_Image_Process),
    .RGB_Data_Src(RGB_Data_Out_BW), //���õ����Ѿ�2ֵ�������������
    .RGB_HSync_Src(RGB_HSync_Src), 
    .RGB_VSync_Src(RGB_VSync_Src), 
    .RGB_VDE_Src(RGB_VDE_Src),
    .RGB_x_Src(RGB_x_Src),
    .RGB_y_Src(RGB_y_Src),
    
    .left(left),
    .right(right),
    .top(top),
    .bottom(bottom),
    .num(num)
    
    
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
    
    .left(left),
    .right(right),
    .top(top),
    .bottom(bottom),
    .num(num),
    
    .RGB_Data(RGB_Data), 
    .RGB_HSync(RGB_HSync), 
    .RGB_VSync(RGB_VSync),
    .RGB_VDE(RGB_VDE) 
    
    );
    
endmodule 