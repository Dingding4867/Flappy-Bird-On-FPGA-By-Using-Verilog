module singleRandomColumn(
		input logic Clock, Reset, 
		input logic [3:0] fakeRandom,
		output logic [15:0] wall);
		
		always_ff @(posedge Clock) begin
			
			if(Reset)
				wall <= 16'b0000000000000000;
			else begin
				if(fakeRandom == 4'b0000) 		 //0
					wall = 16'b1100011111111111;
				else if (fakeRandom == 4'b0001)//1
					wall = 16'b1110001111111111;
				else if (fakeRandom == 4'b0010)//2
					wall = 16'b1111000111111111;
				else if (fakeRandom == 4'b0011)//3
					wall = 16'b1111100011111111;
				else if (fakeRandom == 4'b0100)//4
					wall = 16'b1111110001111111;
				else if (fakeRandom == 4'b0101)//5 、、
					wall = 16'b1111111000111111;
				else if (fakeRandom == 4'b0110)//6
					wall = 16'b1111111100011111;
				else if (fakeRandom == 4'b0111)//7 、、
					wall = 16'b1111111110001111;
				else if (fakeRandom == 4'b1000)//8 、、
					wall = 16'b1111111111000111;
				else if (fakeRandom == 4'b1001)//9
					wall = 16'b1111111111100011;
				else if (fakeRandom == 4'b1010)//10
					wall = 16'b1111111111110001;
				else if (fakeRandom == 4'b1011)//11
					wall = 16'b1111111111111000;
				else if (fakeRandom == 4'b1100)//12
					wall = 16'b0001111111111111;
				else if (fakeRandom == 4'b1101)//13
					wall = 16'b1000111111111111;
				else if (fakeRandom == 4'b1110)//14
					wall = 16'b1111100000000111;
				else                           //15
					wall = 16'b1100000111111111;
			end
		end

endmodule	
		