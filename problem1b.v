module TFlipFlop(
	input t, 
	input clk, 
	input clear, 
	output reg q);
	
	always @(negedge clk, posedge clear)
		if (clear) 
			q = 0; 
		else if(t)
			q <= ~q;

endmodule

module Test;

	reg t, clk, clear;
	wire q;

	TFlipFlop circuit(t, clk, clear, q);

	initial begin
		clear = 1;
		#10 clear = 0;
	end 
	
	initial begin 
		clk = 1;
		forever
			#5 clk = ~clk;
	end 

	initial begin 
		$monitor("%d t=%b clock=%b clear=%d, q=%b", 
			$time,
			t, clk, clear, q);
		t = 0;
		#10 t = 1; 
		#10 t = 0;
		#10 t = 1;
		
		#10 $finish; 

	end
endmodule