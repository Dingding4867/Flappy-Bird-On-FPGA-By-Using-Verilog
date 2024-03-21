module Metastability(
	input logic in, Clock,
	output logic out);
	
	logic middle;
	
	
	always_ff@(posedge Clock) begin
		middle <= in;
	end
	
	always_ff@(posedge Clock) begin
		out <= middle;
	end
	
endmodule
	
	
module Metastability_testbench();

	logic in, out, Clock;
	Metastability dut (.in, .Clock, .out);
	

	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end
	

	initial begin
	

		in <= 1;					@(posedge Clock);
									@(posedge Clock);
		in <= 0;					@(posedge Clock);
									@(posedge Clock);
		in <= 0;					@(posedge Clock);
									@(posedge Clock);
		in <= 1;					@(posedge Clock);
		in <= 0;					@(posedge Clock);
									@(posedge Clock);
		in <= 1;					@(posedge Clock);
									@(posedge Clock);
									@(posedge Clock);
		in <= 0; 				@(posedge Clock);
									@(posedge Clock);
									@(posedge Clock);
		in <= 1;					@(posedge Clock);
		in <= 0;					@(posedge Clock);
									@(posedge Clock);
									@(posedge Clock);
									@(posedge Clock);
		in <= 1;					@(posedge Clock);
									@(posedge Clock);
		$stop;
	end
endmodule