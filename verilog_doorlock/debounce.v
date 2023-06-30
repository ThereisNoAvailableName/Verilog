module debounce(
	clk,
	n_rst, 
	din, 
	dout 
);

//parameter T_ONE_SEC = 26'h2FA_F080 = d50_000_000;
//parameter T_20MS = 20'hF_4240 = d1_000_000;
// 2^N * 20 ns = 40 ms
parameter N = 21;
parameter T_20MS = 20'h0_0008;
parameter D_INIT = 1'b0;


input 	clk;
input	n_rst;
input	din;
output 	dout;

localparam [1:0] S_ZERO  = 2'b00;
localparam [1:0] S_WAIT0 = 2'b01;
localparam [1:0] S_ONE   = 2'b10;
localparam [1:0] S_WAIT1 = 2'b11;

reg [1:0] state, next_state;
reg [N-1:0] cnt, next_cnt;

always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		state <= S_ZERO;
		//state <= S_ONE;
		cnt   <= 1'b0;
	end
	else begin
		state <= next_state;
		cnt <= next_cnt;
	end

reg db_level;
always @(state or cnt or din or next_cnt) 	
	case (state)
		S_ZERO : begin
		  //start counting when din = 1'b0 (push -> 0)
			next_state = (din == 1'b0)? S_WAIT1 : state;
			next_cnt = {N{1'b1}};
			//din  PUSH_OFF: 1, PUSH_ON: 0  ->  dout  PUSH_OFF: 0, PUSH_ON: 1
			//for edge detection
			db_level = 1'b0;
		end
		S_WAIT1   : begin
			next_state = (next_cnt == {N{1'b0}})? S_ONE : state;
			next_cnt   = cnt - {{(N-1){1'b0}},1'b1};
			db_level = 1'b1;
		end
		S_ONE : begin
			next_state = (din == 1'b1)? S_WAIT0 : state;
			next_cnt = {N{1'b1}};
			db_level = 1'b1;
		end
		S_WAIT0 : begin
			next_state = (next_cnt == {N{1'b0}})? S_ZERO : state;
			next_cnt   = cnt - {{(N-1){1'b0}},1'b1};
			db_level = 1'b0;
		end
		default  : begin
			next_state = S_ZERO;
			next_cnt = cnt;
			db_level = 1'b0;
		end
	endcase

assign dout = db_level;	

endmodule