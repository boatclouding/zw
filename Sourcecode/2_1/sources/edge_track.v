`timescale 1ns / 1ps
module edge_track(
    input clk,
    input [23:0]RGB_Data_Src, 
    input [10:0]RGB_x_Src,
    input [9:0]RGB_y_Src,
    
    output reg [10:0]Left,
    output reg [10:0]Right,
    output reg [9:0]Top,
    output reg [9:0]Bottom
    );
    
    //检测边界值，在这里统一修改
    localparam  top_boundary=10'd120,
                bottom_boundary=10'd600,
                left_boundary=11'd440,
                right_boundary=11'd840;
    
    localparam  fall_edge=2'b10,//下降沿
                rise_edge=2'b01;//上升沿
                
    //边界(给初始值是为了后面的判断)
    reg [10:0]left=right_boundary;
    reg [10:0]right=left_boundary;
    reg [9:0]top=bottom_boundary;
    reg [9:0]bottom=top_boundary;
                
    reg [1:0]check_x=2'b11;//判断x方向上下升沿
    reg [1:0]check_y=2'b11;//判断y方向上下升沿(以行为单位，当前行有黑色为0，全白为1)
    reg num_exist_check=1'b0;//当前行有无数字检测，有数字为1
    
    
    //check_x,check_y上下升沿判断 
    always@(posedge clk)begin
        if(RGB_Data_Src[7:0]>=8'd200)begin//当前像素为255
            check_x<={check_x[0],1'b1};
        end else begin//当前像素为0，一定遇到数字了
            check_x<={check_x[0],1'b0};
            if(num_exist_check==1'b0)
                num_exist_check<=1'b1;
        end
        //边界清零 
        if(RGB_x_Src==left_boundary-2)
        begin
            num_exist_check<=1'b0;
            check_x<=2'b11;
        end
        if(RGB_x_Src==right_boundary)begin//行结尾判断该行有无数字
            if(num_exist_check==1'b1)begin//有数字
                check_y<={check_y[0],1'b0};
                num_exist_check<=0;
            end else begin//无数字
                check_y<={check_y[0],1'b1};
            end
        end
    end
    
    //确定边框位置
    always@(posedge clk)begin
        //确定上边界
        if(check_y==fall_edge)//遇到数字
            if((top>(RGB_y_Src-1))&&(RGB_y_Src-1>top_boundary))
                top<=RGB_y_Src-1;
        //确定下边界
        if(check_y==rise_edge)//离开数字
            if((bottom<RGB_y_Src)&&(RGB_y_Src<bottom_boundary))
                bottom<=RGB_y_Src;
        //确定左边界
        if(check_x==fall_edge)begin//x方向遇到数字
            if((left>RGB_x_Src-1)&&(RGB_x_Src-1>left_boundary))//确保左边界为最左值
                left<=RGB_x_Src-1;
        end
        //确定右边界
        if(check_x==rise_edge)begin//x方向离开数字
            if((right<RGB_x_Src)&&(RGB_x_Src<right_boundary))
                right<=RGB_x_Src;
        end
        
        //当前帧结束后初始化
        if(RGB_x_Src==11'd1220&&RGB_y_Src==10'd715)begin
            left<=right_boundary;
            right<=left_boundary;
            top<=bottom_boundary;
            bottom<=top_boundary;
        end
        
        //传出边界值
        if(RGB_x_Src==11'd1220&&RGB_y_Src==10'd601)begin//底部边界赋值后，代表已经处理完边界
            Left<=left-10;
            Right<=right+10;
            Top<=top-10;
            Bottom<=bottom+10; 
        end
    end
    
    
endmodule
