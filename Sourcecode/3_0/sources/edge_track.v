`timescale 1ns / 1ps
module edge_track(
    input clk,
    input [23:0]RGB_Data_Src, 
    input [10:0]RGB_x_Src,
    input [9:0]RGB_y_Src,
    
    //��ⷶΧ
    input [10:0]left_boundary,
    input [10:0]right_boundary,
    input [9:0]top_boundary,
    input [9:0]bottom_boundary,
    
    //����߽�
    output reg [10:0]Left,
    output reg [10:0]Right,
    output reg [9:0]Top,
    output reg [9:0]Bottom
    );
    
    reg [10:0]left;
    reg [10:0]right;
    reg [9:0]top;
    reg [9:0]bottom;
    
    //���߽�ֵ��������ͳһ�޸�
    
    localparam  fall_edge=2'b10,//�½���
                rise_edge=2'b01;//������
                
    //�߽�(����ʼֵ��Ϊ�˺�����ж�)
                
    reg [1:0]check_x=2'b11;//�ж�x������������
    reg [1:0]check_y=2'b11;//�ж�y������������(����Ϊ��λ����ǰ���к�ɫΪ0��ȫ��Ϊ1)
    reg num_exist_check=1'b0;//��ǰ���������ּ�⣬������Ϊ1
    
    
    //check_x,check_y���������ж� 
    always@(posedge clk)begin   
        if(RGB_Data_Src[7:0]>=8'd200)begin//��ǰ����Ϊ255
            check_x<={check_x[0],1'b1};
        end else begin//��ǰ����Ϊ0��һ������������
            check_x<={check_x[0],1'b0};
            if(num_exist_check==1'b0)
                num_exist_check<=1'b1;
        end
        //�߽����� 
        if(RGB_x_Src==left_boundary-2)
        begin
            num_exist_check<=1'b0;
            check_x<=2'b11;
        end
        if(RGB_x_Src==right_boundary)begin//�н�β�жϸ�����������
            if(num_exist_check==1'b1)begin//������
                check_y<={check_y[0],1'b0};
                num_exist_check<=0;
            end else begin//������
                check_y<={check_y[0],1'b1};
            end
        end
    end
    
    //ȷ���߿�λ��
    always@(posedge clk)begin
        //ȷ���ϱ߽�
        if(check_y==fall_edge)//��������
            if((top>(RGB_y_Src-1))&&(RGB_y_Src-1>top_boundary))
                top<=RGB_y_Src-1;
        //ȷ���±߽�
        if(check_y==rise_edge)//�뿪����
            if((bottom<RGB_y_Src)&&(RGB_y_Src<bottom_boundary))
                bottom<=RGB_y_Src;
        //ȷ����߽�
        if(check_x==fall_edge)begin//x������������
            if((left>RGB_x_Src-1)&&(RGB_x_Src-1>left_boundary))//ȷ����߽�Ϊ����ֵ
                left<=RGB_x_Src-1;
        end
        //ȷ���ұ߽�
        if(check_x==rise_edge)begin//x�����뿪����
            if((right<RGB_x_Src)&&(RGB_x_Src<right_boundary))
                right<=RGB_x_Src;
        end
        //��ʼʱ��ʼ��
        if(RGB_x_Src==1&&RGB_y_Src==1)
        begin
            left=right_boundary;
            right=left_boundary;
            top=bottom_boundary;
            bottom=top_boundary;
        end     
        //��ǰ֡�������ʼ��
        //if(RGB_x_Src==11'd1220&&RGB_y_Src==10'd715)
        
        //�����߽�ֵ
        if(RGB_x_Src==11'd1220&&RGB_y_Src==10'd601)begin//�ײ��߽縳ֵ�󣬴����Ѿ�������߽�
            Left<=left-15;
            Right<=right+15;
            Top<=top-15;
            Bottom<=bottom+15; 
        end
    end
    
    
endmodule