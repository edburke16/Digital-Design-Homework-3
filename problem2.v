module SRFlipFlop(input s, input r, input clock, input clear, 
	output reg q, output reg qbar);
	
	always @(posedge clock, negedge clear)
		if (~clear) begin
			q <= 0;
			qbar <= 1;
			end
		else
			case({s, r})
				2'd1: begin q <= 0; qbar <= 1; end
				2'd2: begin q <= 1; qbar <= 0; end
				2'd3: begin q <= 1'bx; qbar <= 1'bx; end // Undefined due to oscillation
			endcase
	
endmodule

module Test;

	reg s, r, clock, clear;
	wire q, qbar;

	SRFlipFlop circuit(s, r, clock, clear, q, qbar);

	initial begin
		clear = 0;
		#10 clear = 1;
	end 
	
	initial begin 
		clock = 1;
		forever
			#5 clock = ~clock;
	end 

	initial begin 
		$monitor("%d s=%b r=%b clock=%b clear=%d, q=%b qbar=%b", 
			$time,
			s, r, clock, clear, q, qbar);
		s = 0;
		r = 0;
		#10 s = 0; r = 1;
		#10 s = 1; r = 0; 
		#10 s = 1; r = 1;
		
		#10 $finish; 

	end
endmodule