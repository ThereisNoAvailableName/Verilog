//1 clk -> 0.5sec
//2^28 * 20ns

module delay(
  clk,
  n_rst,
  din,
  dout
);

parameter N = 28;

localparam S_ZERO = 1'b0;
localparam S_WAIT = 1'b1;
  
input clk;
input n_rst;
input din;

output dout;
  
reg [N-1:0] cnt, next_cnt;
reg state, next_state;
reg level;

always @(posedge clk or negedge n_rst) begin
  if (!n_rst) begin
    state <= S_ZERO;
    cnt <= {N{1'b0}};
  end
  else begin
    state <= next_state;
    cnt <= next_cnt;
  end
end

always @(state or cnt or din or next_cnt) begin
  case (state)
    S_ZERO : begin
      next_state = (din == 1'b1)? S_WAIT : state;
      next_cnt = {N{1'b1}};
      level = 1'b0;
    end 
    S_WAIT : begin
      next_state = (cnt == {N{1'b0}})? S_ZERO : state;
      next_cnt = cnt - {{(N-1){1'b0}}, 1'b1};
      level = 1'b1;
    end
  endcase
end

assign dout = level;

endmodule