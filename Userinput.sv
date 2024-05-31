module Userinput (
	input logic Clock, Reset, key,
	output logic pressedKey);
	
	enum {press, unpress} ps, ns;
	
	always_comb begin
		case(ps)
			press:
				if(key) ns = press;
				else ns = unpress;
			unpress:
				if(key) ns = press;
				else ns = unpress;	
		endcase 
	end
	
	always_ff @(posedge Clock) begin 
		ps <= ns;
	end
	
	assign pressedKey = (ps == unpress) & key;
	
endmodule


module Userinput_testbench();

		logic Clock, Reset, key, pressedKey;
		
		Userinput dut (.Clock, .Reset, .key, .pressedKey);
		parameter clock_period = 100;
		initial begin
			Clock <= 0;
			forever #(clock_period /2) Clock <= ~Clock;
					
		end 

		initial begin
									  @(posedge Clock);
		Reset <= 1;				  @(posedge Clock);
		
		Reset <= 0; key<=0;     @(posedge Clock); 		
									 
						key<=1;     @(posedge Clock);
							
						key<=0;     @(posedge Clock); 		
									 
						key<=1;     @(posedge Clock);
					    
						key<=0;     @(posedge Clock); 		
									 
						key<=1;     @(posedge Clock);	
						
						key<=0;     @(posedge Clock); 		
									 
						key<=1;     @(posedge Clock);
						
						key<=0;     @(posedge Clock); 		
									 
						key<=1;     @(posedge Clock);
						
						key<=0;     @(posedge Clock); 		
									 
						key<=1;     @(posedge Clock);
						
						key<=0;     @(posedge Clock); 		
									 
						key<=1;     @(posedge Clock);
						
						key<=0;     @(posedge Clock); 		
									 
						key<=1;     @(posedge Clock);
					
			$stop; 						
							
		end 
		
endmodule		
	