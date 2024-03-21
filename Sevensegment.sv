module Sevensegment (
	input logic [3:0] number,
	output logic [6:0] Hex);
	
	always_comb begin 
		case(number)//0 is on, 1 is off
			4'b0001: Hex = 7'b1111001;//1
			4'b0010: Hex = 7'b0100100;//2
			4'b0011: Hex = 7'b0110000;//3
			4'b0100: Hex = 7'b0011001;//4
			4'b0101: Hex = 7'b0010010;//5
			4'b0110: Hex = 7'b0000010;//6
			4'b0111: Hex = 7'b1111000;//7
			4'b1000: Hex = 7'b0000000;//8
			4'b1001: Hex = 7'b0010000;//9
			default: Hex = 7'b1000000;//0
		endcase
	end
	
endmodule