module Computerinput(
	input logic Clock, Reset,
	output logic tick); 
	
	logic [9:0] counter;
		
	always_ff @ (posedge Clock) begin
		if(Reset) begin
			counter <= 0;
			tick <= 0;
		end else if (counter == 450) begin
			counter <= 0;
			tick <= 1;
		end else begin 
			counter <= counter+1;
			tick<=0;
		end
	end
	
	
endmodule