`timescale 1ns/1ps
`define T_CLK 10


module tb_master();
  
  reg clk, n_rst, sdata, start;
  wire sclk, cs_n;
  wire [7:0] dout;
  
  integer j;
  
  
  initial begin
    clk = 1'b1;
	  n_rst = 1'b0;
	  #(`T_CLK * 2)
	  @(negedge clk) n_rst = 1'b1;
  end

  always #(`T_CLK/2) clk = ~clk;


  initial begin
    sdata = 1'b1;
    start = 1'b0;
    
    #(`T_CLK * 100)
    start = 1'b1;
    wait(cs_n == 1'b0)
    start = 1'b0;
    
    for (j = 0; j < 15; j = j + 1) begin
      @(negedge sclk);
      if (j < 3) begin
        sdata = 1'b0;
      end
      else if (j < 11) begin
        sdata = j[0];
      end
      else begin
        sdata = 1'b0;
      end
    end
    
    sdata = 1'b1;
    #(`T_CLK * 100)
    
    #(`T_CLK*5) $stop;
    
  end
  
  
  master u_master(
    .clk(clk),
    .n_rst(n_rst),
    .sdata(sdata),
    .start(start),
    .sclk(sclk),
    .cs_n(cs_n),
    .dout(dout)
    );
    
endmodule
  
   
