module edge_detector_sclk(
  clk,
  n_rst,
  din,
  dout,
  cnt1
  );
  
  input clk;
  input n_rst;
  input [4:0] cnt1;
  
  input din;
  output dout;
  
  reg d1;
  reg d2;
  
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      d1 <= 1'b0;
      d2 <= 1'b0;
    end
    else begin
      d1 <= (cnt1 == 5'h01)? din : d1;
      d2 <= (cnt1 == 5'h01)? d1 : d2;
    end
  end
  
  assign dout = ((d1 == 1'b1) && (d2 == 1'b0))? 1'b1 : 1'b0;
  
  
endmodule 
