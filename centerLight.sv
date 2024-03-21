module centerLight (Clock, Reset, up, bottom, nUp, nBottom, lightOn);
	
	input logic Clock, Reset, up, bottom, nUp, nBottom;
	// when lightOn is true, the center light should be on.
	
	output logic lightOn;

	
	enum {On, Off} ps, ns;
	
	always_comb begin
		case (ps)
		
			On: if (up ^ bottom)
					ns = Off;// present Led is On, when pressed L or R, Led's next state will be Off
				 else
				   ns = On;
				
			Off: if((nBottom & up & ~bottom) || ( nUp & bottom & ~up))
					ns = On;//  present left On---- pressed(R) --- next right on, present left off
				  else
					ns = Off;
		endcase
	end
	
	
	assign lightOn = (ps == On);
	
	
	always_ff@(posedge Clock) begin
		if (Reset)// 1
			ps <= On;
		else// 0
			ps <= ns;
	end
	
endmodule

//module centerLight_testbench();
//	logic Clock, Reset;
//	logic L, R, NL, NR;
//	logic lightOn;
//	
//	centerLight dut(.Clock, .Reset, .L, .R, .NL, .NR, .lightOn);
//	
//		// Set up a simulated clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		Clock <= 0;
//		forever #(CLOCK_PERIOD/2) Clock <= ~Clock; // Forever toggle the clock
//	end
//	
//	// Set up the inputs to the design. Each line is a clock cycle.
//	initial begin// 4 input value: L, R, NL, NR.  (NR and NL) will not light up simutanuosly
//																		@(posedge Clock);
//		Reset <= 1; 												@(posedge Clock);
//		Reset <= 0; 												@(posedge Clock);
//		
//		L <= 1; R<= 0; NL <= 0; NR <= 0; 					@(posedge Clock);// 1000
//		L <= 1; R<= 0; NL <= 0; NR <= 1; 					@(posedge Clock);// 1001
//		L <= 1; R<= 1; NL <= 0; NR <= 0; 					@(posedge Clock);// 1100
//		L <= 1; R<= 1; NL <= 0; NR <= 1; 					@(posedge Clock);// 1101
//		L <= 1; R<= 1; NL <= 1; NR <= 0; 					@(posedge Clock);// 1110
//		L <= 0; R<= 1; NL <= 0; NR <= 0; 					@(posedge Clock);// 0100
//		L <= 1; R<= 1; NL <= 0; NR <= 0; 					@(posedge Clock);// 1100
//		L <= 1; R<= 1; NL <= 0; NR <= 1; 					@(posedge Clock);// 1101
//		L <= 0; R<= 1; NL <= 1; NR <= 0; 					@(posedge Clock);// 0110
//		
//		$stop;
//	end
//
//endmodule