`timescale 1ns / 1ps
module decode(
    input clk,
    input [6:0]num,//最大为81
    output reg[7:0]BCD_code
    );
    always@(posedge clk)begin
        case(num)
            7'd0:BCD_code<=8'b0000_0000;
            7'd1:BCD_code<=8'b0000_0001;
            7'd2:BCD_code<=8'b0000_0010;
            7'd3:BCD_code<=8'b0000_0011;
            7'd4:BCD_code<=8'b0000_0100;
            7'd5:BCD_code<=8'b0000_0101;
            7'd6:BCD_code<=8'b0000_0110;
            7'd7:BCD_code<=8'b0000_0111;
            7'd8:BCD_code<=8'b0000_1000;
            7'd9:BCD_code<=8'b0000_1001;
            
            7'd10:BCD_code<=8'b0001_0000;
            7'd11:BCD_code<=8'b0001_0001;
            7'd12:BCD_code<=8'b0001_0010;
            7'd13:BCD_code<=8'b0001_0011;
            7'd14:BCD_code<=8'b0001_0100;
            7'd15:BCD_code<=8'b0001_0101;
            7'd16:BCD_code<=8'b0001_0110;
            7'd17:BCD_code<=8'b0001_0111;
            7'd18:BCD_code<=8'b0001_1000;
            7'd19:BCD_code<=8'b0001_1001;
            
            7'd20:BCD_code<=8'b0010_0000;
            7'd21:BCD_code<=8'b0010_0001;
            7'd22:BCD_code<=8'b0010_0010;
            7'd23:BCD_code<=8'b0010_0011;
            7'd24:BCD_code<=8'b0010_0100;
            7'd25:BCD_code<=8'b0010_0101;
            7'd26:BCD_code<=8'b0010_0110;
            7'd27:BCD_code<=8'b0010_0111;
            7'd28:BCD_code<=8'b0010_1000;
            7'd29:BCD_code<=8'b0010_1001;
            
            7'd30:BCD_code<=8'b0011_0000;
            7'd31:BCD_code<=8'b0011_0001;
            7'd32:BCD_code<=8'b0011_0010;
            7'd33:BCD_code<=8'b0011_0011;
            7'd34:BCD_code<=8'b0011_0100;
            7'd35:BCD_code<=8'b0011_0101;
            7'd36:BCD_code<=8'b0011_0110;
            7'd37:BCD_code<=8'b0011_0111;
            7'd38:BCD_code<=8'b0011_1000;
            7'd39:BCD_code<=8'b0011_1001;
            
            7'd40:BCD_code<=8'b0100_0000;
            7'd41:BCD_code<=8'b0100_0001;
            7'd42:BCD_code<=8'b0100_0010;
            7'd43:BCD_code<=8'b0100_0011;
            7'd44:BCD_code<=8'b0100_0100;
            7'd45:BCD_code<=8'b0100_0101;
            7'd46:BCD_code<=8'b0100_0110;
            7'd47:BCD_code<=8'b0100_0111;
            7'd48:BCD_code<=8'b0100_1000;
            7'd49:BCD_code<=8'b0100_1001;
            
            7'd50:BCD_code<=8'b0101_0000;
            7'd51:BCD_code<=8'b0101_0001;
            7'd52:BCD_code<=8'b0101_0010;
            7'd53:BCD_code<=8'b0101_0011;
            7'd54:BCD_code<=8'b0101_0100;
            7'd55:BCD_code<=8'b0101_0101;
            7'd56:BCD_code<=8'b0101_0110;
            7'd57:BCD_code<=8'b0101_0111;
            7'd58:BCD_code<=8'b0101_1000;
            7'd59:BCD_code<=8'b0101_1001;
            
            7'd60:BCD_code<=8'b0110_0000;
            7'd61:BCD_code<=8'b0110_0001;
            7'd62:BCD_code<=8'b0110_0010;
            7'd63:BCD_code<=8'b0110_0011;
            7'd64:BCD_code<=8'b0110_0100;
            7'd65:BCD_code<=8'b0110_0101;
            7'd66:BCD_code<=8'b0110_0110;
            7'd67:BCD_code<=8'b0110_0111;
            7'd68:BCD_code<=8'b0110_1000;
            7'd69:BCD_code<=8'b0110_1001;
            
            7'd70:BCD_code<=8'b0111_0000;
            7'd71:BCD_code<=8'b0111_0001;
            7'd72:BCD_code<=8'b0111_0010;
            7'd73:BCD_code<=8'b0111_0011;
            7'd74:BCD_code<=8'b0111_0100;
            7'd75:BCD_code<=8'b0111_0101;
            7'd76:BCD_code<=8'b0111_0110;
            7'd77:BCD_code<=8'b0111_0111;
            7'd78:BCD_code<=8'b0111_1000;
            7'd79:BCD_code<=8'b0111_1001;
            
            7'd80:BCD_code<=8'b1000_0000;
            7'd81:BCD_code<=8'b1000_0001;
            
            default:BCD_code<=8'b1011_1011;//随便改
        endcase
    end
endmodule
