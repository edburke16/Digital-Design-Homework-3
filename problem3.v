module Incrementor(input inc, input clock, input clear, 
	output reg[31:0] q);
	
	always @(negedge clock, posedge clear) 
		if (clear) 
			q = 32'd0;
		else 
			if(inc)
				q = q + 32'd3;
	
endmodule

module Test;

	reg inc, clock, clear;
	wire[31:0] q;

	Incrementor circuit(inc, clock, clear, q);

	initial begin
		clear = 1;
		#10 clear = 0;
	end 
	
	initial begin 
		clock = 1;
		forever
			#5 clock = ~clock;
	end 

	initial begin 
		$monitor("%d inc=%b clock=%b clear=%d, q=%d", 
			$time,
			inc, clock, clear, q);
		inc = 0;
		#10 inc = 1;
		#10
		#10
		#10 inc = 0;
		#10
		
		#10 $finish; 

	end
endmodule