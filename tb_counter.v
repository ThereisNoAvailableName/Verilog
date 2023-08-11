//testbench for 4bit up/down counter
`timescale 1ns/1ps
`define T_CLK 10

module tb_counter;
  
  reg clk, n_rst, up_down;
  wire [3:0] cnt;
  
  
  initial begin
    clk = 1'b1;
  end
  
  always #(`T_CLK/2) clk = ~clk;
  
  
  initial begin
    //case 1 : up counter
    up_down = 1'b1;
    
    n_rst = 1'b0;
    #(`T_CLK * 2)
    @(negedge clk) n_rst = 1'b1;
    
    #(`T_CLK * 18)
    
    //case 2 : down counter
    up_down = 1'b0;
    
    n_rst = 1'b0;
    #(`T_CLK * 2)
    @(negedge clk) n_rst = 1'b1;
    
    #(`T_CLK * 18)
    
    $stop;
  end
  
  
  counter u_counter(
    .clk(clk),
    .n_rst(n_rst),
    .up_down(up_down),
    .cnt(cnt)
  );
  
endmodule
      