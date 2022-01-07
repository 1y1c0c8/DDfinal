module score(clock, reset, button_left, button_right, score, score10, right);
	input button_left, button_right, reset, clock, right;
	output reg[3:0] score, score10;
	reg temp;
	
	always@(/*posedge clock or */negedge reset or posedge right)
	begin
		if(!reset)
		begin
			score <= 4'd0;
			score <= 4'd0;
		end
		else if(right)
			begin
				if(score == 4'd9)
				begin
					score10 <= score10 + 4'd1;
					score <= 4'd0;
				end
				else
					score <= score + 4'd1;
			end
	end
endmodule
