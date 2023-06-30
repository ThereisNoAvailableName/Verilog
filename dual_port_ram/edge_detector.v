module edge_detector(
  clk,
  n_rst,
  din,
  dout
  );
  
  input clk;
  input n_rst;
  
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
      d1 <= din;
      d2 <= d1;
    end
  end
  
  assign dout = ((d1 == 1'b1) && (d2 == 1'b0))? 1'b1 : 1'b0;
  
  
endmodule 
