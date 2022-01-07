module DDfinal(
	input clk, 
	input left, 
	input right, 
	input reset,
	output reg [7:0] dot_row, 
	output [7:0] boss_dot_col,
	output [7:0] player_dot_col,
	output [6:0] t,
	output [6:0] time10,
	output [6:0] score,
	output [6:0] score10);

	reg clk_div;
	reg temp = 1;
	reg [31:0] clk_count=0;
	always@(posedge clk ) begin
		if (clk_count == 25000) begin 
			clk_count<=32'd0;
         clk_div <= ~clk_div;
      end
      else begin 
			clk_count <= clk_count + 32'd1;
      end
   end
	
	wire [1:0] boss_cur_state;
	wire [1:0] player_cur_state;
	wire correct;
//	assign correct = boss_cur_state == player_cur_state;
	
	assign correct = boss_cur_state == player_cur_state ? 1 : 0;
	
	boss b(.clk(clk), .right(correct), .row_count(row_count), .dot_col(boss_dot_col), .cur_state(boss_cur_state), .reset(reset),.scoreout(score),.score10out(score10));
	//print and correct to check weather the action is same 
	player p(clk, left, right, row_count, player_dot_col, player_cur_state);
	
	reg [2:0] row_count=0;
	always@(posedge clk_div) begin
		row_count <= row_count + 1;
		case (row_count)
          3'd0: dot_row <= 8'b01111111;
          3'd1: dot_row <= 8'b10111111;
          3'd2: dot_row <= 8'b11011111;
          3'd3: dot_row <= 8'b11101111;
          3'd4: dot_row <= 8'b11110111;
          3'd5: dot_row <= 8'b11111011;
          3'd6: dot_row <= 8'b11111101;
          3'd7: dot_row <= 8'b11111110;
      endcase
	end
	
//	always@(correct)
//	begin
//	if(correct == 1) temp = 0;
//	score_and_time st(clk, reset, t, time10, score, score10,correct);
endmodule