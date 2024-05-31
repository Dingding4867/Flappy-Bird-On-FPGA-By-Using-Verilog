module LFSR (
	
	input logic Clock, Reset,
	output logic [3:0] patterns);// 4-bit random number 16 possibilities, fake randoms
	
	logic [3:0] counter;
		
	always_ff @ (posedge Clock) begin
		if(Reset | counter == 12)// 24Hz, half of second, half clock cycle
			counter <= 0;
		else
			counter <= counter +1;
	end
		
	always_ff@(posedge Clock) begin
		if(Reset) begin
			patterns <= 4'b0000;// Q:   1 2 3 4
			                 // index:  3 2 1 0
		end 
		else begin
			if (counter == 0) begin 
				patterns <= { ~(patterns[1] ^ patterns[0]), patterns[3:1] };
			end
		end
	end
	

endmodule


module LFSR_testbench();
	// Testbench signals
	logic Clock, Reset;
	logic [3:0] patterns;
	
	// Instantiates LFSR
	LFSR dut(.Clock, .Reset, .patterns);
	
	// Set up clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	
	// Generate some possibilites
	initial begin
		Reset <= 1;				@(posedge Clock);
		Reset <= 0;				@(posedge Clock);
					  repeat(150)@(posedge Clock);
		$stop;
	end
endmodule