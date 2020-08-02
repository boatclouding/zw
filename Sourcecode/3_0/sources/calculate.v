`timescale 1ns / 1ps
module calculate(
    input clk,
    input [3:0]i_num1,//第一个数
    input [3:0]i_num2,//第二个数
    input [3:0]operation,//运算符
    output reg [3:0]o_num1,
    output reg [3:0]o_num2,
    output reg [3:0]char,
    output reg [3:0]shiwei,
    output reg [3:0]gewei
    );
    reg [6:0]outcome;
    wire [7:0]bcd;
    always@(posedge clk)begin
        case(operation)
            4'b1111:outcome<=i_num1+i_num2;
            4'b1110:begin
                        if(i_num1>=i_num2)
                            outcome<=i_num1-i_num2;
                        else
                            outcome<=7'd99;
                    end
            4'b1101:outcome<=i_num1*i_num2;
            4'b1100:outcome<=7'd99;
        endcase
    end
    
    decode decode1(
                .clk(clk),
                .num(outcome),
                .BCD_code(bcd)
            );
    
    always@(posedge clk)begin
        o_num1<=i_num1;
        o_num2<=i_num2;
        char<=operation;
        shiwei<=bcd[7:4];
        gewei<=bcd[3:0];
    end
endmodule
