module countScore(
	input logic Clock, Reset, death, outofbounddeath,
	output logic [3:0] hundredsDigit, tensDigit, unitsDigit);
	
	integer countHundreds, countTens, countUnits;
	
	logic [3:0] counter;
	logic [3:0] deletefirstOne;
	

	
	
	always_ff @(posedge Clock) begin
		if(Reset)// 24Hz, half of second, half clock cycle
			counter <= -1;
		else if( counter ==12)
			counter <= 0;
		else
			counter <= counter +1;
	end
	
	assign hundredsDigit = countHundreds;
	assign tensDigit = countTens;
	assign unitsDigit = countUnits;
	
	
	always_ff @(posedge Clock) begin
			if(Reset) begin
				countHundreds <=0;
				countTens <=0;
				countUnits <=-1;
			end else begin
			if(counter == 12) begin
					if(~death & ~outofbounddeath) begin
						if(countUnits ==9) begin// 009
							countUnits <=0;
								if(countTens ==9) begin// 099
									countTens <=0;
										if(countHundreds ==9) begin// 999
											countHundreds <=0;
										end else begin
											countHundreds <= countHundreds+1;
										end
								end else begin
									countTens <= countTens+1;
								end
						end else begin
							countUnits <= countUnits+1;
						end
					end
				end
			end
	end
endmodule
