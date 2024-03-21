module edgeLight(Clock, Reset, upLight, downLight, up, bottom, outDeath); 
	input logic Clock, Reset, upLight, downLight, up, bottom;
	output logic outDeath;
	
	enum {die, notDie} ps, ns;
	
	always_comb begin
		case (ps)
			die: 
				ns = die;
			notDie: 
				if((upLight & up & ~bottom) || ( downLight & bottom & ~up))
					ns = die;//  present left On---- pressed(R) --- next right on, present left off
				else
					ns = notDie;
		endcase
	end
	
	
	assign outDeath = (ps == die);
	
	
	always_ff@(posedge Clock) begin
		if (Reset)// 1
			ps <= notDie;
		else// 0
			ps <= ns;
	end
endmodule 