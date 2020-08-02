`timescale 1ns / 1ps
module digital_recognition(
    input clk,
    input [23:0]RGB_Data_Src, 
    input [10:0]RGB_x_Src,
    input [9:0]RGB_y_Src,
    
    input [10:0]left,
    input [10:0]right,
    input [9:0]top,
    input [9:0]bottom,
    
    output reg[3:0]num
    );
    
    
    localparam  fall_edge=2'b10,
                rise_edge=2'b01;
     
    localparam  A=4'd0,
                B=4'd1,
                C=4'd2,
                D=4'd3,
                E=4'd4,
                F=4'd5,
                G=4'd6,
                H=4'd7,
                I=4'd8;
    
    parameter P_1_3 = 6'b010101;//1/3 0.333
    parameter P_2_3 = 6'b101011;//2/3 0.667
    parameter P_2_5 = 6'b010101;//2/5 0.4
    parameter P_3_5 = 6'b100010;//3/5 0.6
    


    reg [17:0] y_; //(hcount_l + hcount_r)/2
    reg [17:0] y2233_;
    reg [23:0] x1_; // (vcount_r - vcount_l)*2/5 + vcount_l
    reg [23:0] x2_; // (vcount_r - vcount_l)*2/3 + vcount_l
    
    
    reg [17:0] l_; //(hcount_l + hcount_r)/2
    reg [17:0] r_; //(hcount_l + hcount_r)/2
    reg [22:0] t_; // (vcount_r - vcount_l)*2/5 + vcount_l
    reg [22:0] b_; // (vcount_r - vcount_l)*2/5 + vcount_l
    
    
      //x1,x2,y位置
    reg [10:0]y2233_position;
    reg [10:0]y_position;
    reg [9:0]x1_position;
    reg [9:0]x2_position;
    
    reg [1:0]check_x=2'b11;//判断x方向上下降沿
    reg [1:0]check_y=2'b11;//判断y方向上下升沿
    
    reg x1_state=1'b0;//判断x1上状态，1为检测到数字
    reg x2_state=1'b0;//判断x2上状态，1为检测到数字
    reg y_state=1'b0;//判断y上状态，1为检测到数字
    
  
    
    //交点数
    reg [1:0]x1=2'd0;
    reg [1:0]x2=2'd0;
    reg [1:0]y=2'd0;
    
    //辅助判断，进一步判断为C类时的数字
    reg C_x1_l=1'b0;//x1上交点在左边
    reg C_x1_r=1'b0;//x1上交点在右边
    reg C_x2_l=1'b0;//x2上交点在左边
    reg C_x2_r=1'b0;//x2上交点在右边
    
    reg [3:0]num_signal=4'd9;//为A-F哪一类
    
    //获取y，x1，x2位置
    always@(left or right or top or bottom )
    begin
        l_={1'b0,left,6'b0};
        r_={1'b0,right,6'b0};
        t_={7'b0,top,6'b0};
        b_={7'b0,bottom,6'b0};
        
        y_=(l_+r_)>>1;
        x1_=(t_*P_3_5+b_*P_2_5);
        x2_=(t_*P_1_3+b_*P_2_3);
        y2233_=(y_+r_)>>1;
        
        y_position=y_[16:6];
        y2233_position=y2233_[16:6];
        x1_position=x1_[21:12];
        x2_position=x2_[21:12];
                
    end
    
    //check_x,check_y上下升沿判断   
    always@(posedge clk)begin
        if(RGB_Data_Src[7:0]>=8'd200)begin
            check_x<={check_x[0],1'b1};
            if(RGB_x_Src==y_position)
                check_y<={check_y[0],1'b1};
        end else begin
            check_x<={check_x[0],1'b0};
            if(RGB_x_Src==y_position)
                check_y<={check_y[0],1'b0};
        end 
    end
    
    //x1,x2,y交点个数判断
    always@(posedge clk)begin
        if(RGB_y_Src==x1_position)begin//x1
            if(RGB_x_Src>=left&&RGB_x_Src<=right)begin
                if((check_x==fall_edge)&&(x1_state==1'b0))
                    x1_state<=1'b1;
                else if((check_x==rise_edge)&&(x1_state==1'b1))begin
                    x1<=x1+1;
                    x1_state<=1'b0;
                    //判断交点在左边还是右边
                    if(RGB_x_Src<y_position)
                        C_x1_l<=1'b1;
                    else if(RGB_x_Src>y_position)
                        C_x1_r<=1'b1;
                end
            end
        end 
        else if(RGB_y_Src==x2_position)begin//x2
            if(RGB_x_Src>=left&&RGB_x_Src<=right)begin
                if((check_x==fall_edge)&&(x2_state==1'b0))
                    x2_state<=1'b1;
                else if((check_x==rise_edge)&&(x2_state==1'b1))begin
                    x2<=x2+1;
                    x2_state<=1'b0;
                    //判断交点在左边还是右边
                    if(RGB_x_Src<y2233_position)
                        C_x2_l<=1'b1;
                    else if(RGB_x_Src>y2233_position)
                        C_x2_r<=1'b1;
                end
            end
        end
        if((check_y==fall_edge)&&(y_state==1'b0)&&(RGB_y_Src>=top)&&(RGB_y_Src<=bottom))begin//y
            y_state<=1'b1;
        end 
        else if((check_y==rise_edge)&&(y_state==1'b1)&&(RGB_y_Src>=top)&&(RGB_y_Src<=bottom))begin
            y_state<=1'b0;
            y<=y+1;
        end
        //帧结束数据清零
        if(RGB_x_Src==11'd1220&&RGB_y_Src==10'd712)begin
            C_x1_l<=1'b0;
            C_x1_r<=1'b0;
            C_x2_l<=1'b0;
            C_x2_r<=1'b0;
            x1<=2'd0;
            x2<=2'd0;
            y<=2'd0;
        end
         
    end
    
    //识别数字
    always@(posedge clk)begin
        //确定数字为A-F哪一类
        if(RGB_x_Src==11'd1200&&RGB_y_Src==10'd710)begin
            case({y,x1,x2})
                6'b101010:num_signal<=A;
                6'b010101:num_signal<=B;
                6'b110101:num_signal<=C;
                6'b101001:num_signal<=D;
                6'b110110:num_signal<=E;
                6'b100101:num_signal<=F;
                6'b111010:num_signal<=G;
                6'b111001:num_signal<=H;
                default:num_signal<=I;
            endcase
        end
        
        //确定数字是多少
        if(RGB_x_Src==11'd1210&&RGB_y_Src==10'd711)begin
            case(num_signal)
                A:num<=4'b0000;
                B:num<=4'b0001;
                C:begin
                        case({C_x1_l,C_x1_r,C_x2_l,C_x2_r})
                            4'b0110:num<=4'b0010;
                            4'b0101:num<=4'b0011;
                            4'b1001:num<=4'b0101;
                            default:num<=4'b1011;
                        endcase
                    end
                D:num<=4'b0100;
                E:num<=4'b0110;
                F:num<=4'b0111;
                G:num<=4'b1000;
                H:num<=4'b1001;
                I:num<=4'b1011;
                default:num<=4'b1011;
            endcase
        end    
        
    
    end
    

    
endmodule
