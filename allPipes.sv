module allPipes(
		input logic Clock, Reset,
		input logic [15:0] randomPipes,
		output logic [15:0] [15:0] RedPixels);
		
		
		logic [3:0] counter;// counter will control the space between each pipes
		
		always_ff @(posedge Clock) begin
			if(Reset | counter == 12)// 24Hz, half of second, half clock cycle
				counter <= 0;
			else
				counter <= counter +1;
		end
		
		always_ff @(posedge Clock) begin
			if(Reset) begin 
				for( integer row = 0; row <16; row++) begin
					RedPixels[row][15:0] <= 16'b0000000000000000;
				end
			end else begin
				for( integer row = 0; row <16; row++) begin
					if(counter == 0) begin// only when counter ==0, generate new pipes
						RedPixels[row][0] <= randomPipes[row];// initialize each row, and form the single column
					end else begin
						RedPixels[row][0] <= 1'b0;// when counter is not 0, then red LED will not light up---space
					end
					// above is the right most (newest) pipe
				
					RedPixels [row] [15:1] <= RedPixels [row][14:0];// update the column position from rihgtmost to left based on the counter
				end
			end
		end

endmodule


module allPipes_testbench();
		
		logic Clock, Reset;
		logic [15:0] randomPipes;
		logic [15:0] [15:0] RedPixels;
		
		allPipes dut(.Clock, .Reset, .randomPipes, .RedPixels);
		
		// Set up clock.
		parameter CLOCK_PERIOD = 100;
		initial begin
			Clock <= 0;
			forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
		end
		
		// Generate some possibilites
		initial begin
		
			Reset <=1; @(posedge Clock);
			Reset <=0; @(posedge Clock);
			
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1100011111111111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1110001111111111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111000111111111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111100011111111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111110001111111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111111000111111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111111100011111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111111110001111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111111111000111; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111111111100011; repeat(1)  @(posedge Clock);
			
			randomPipes <=16'b0000000000000000; repeat(11) @(posedge Clock);
			randomPipes <=16'b1111000000011111; repeat(1)  @(posedge Clock);
			$stop;
		end
endmodule
					