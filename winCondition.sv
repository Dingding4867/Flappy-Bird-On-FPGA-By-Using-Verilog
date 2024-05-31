module winCondition(
	input logic Clock, Reset, 
	input logic [15:0][15:0] bird, pipes,
	output logic failed);
	
	logic [15:0] birdPosition;
	
	enum{alive, GGs, Restart} ps, ns;
	
	assign failed = (ps==GGs);
	
	always_comb begin
		case(ps)
			alive: if(bird & pipes)
						ns =GGs;
					  else 
						ns = alive;
			GGs: ns= Restart;
			
			Restart: ns = Restart;
			
		endcase
	end
	
	always_ff @(posedge Clock) begin
		if(Reset)
			ps<= alive;
		else
			ps<= ns;
	end

endmodule
		
		