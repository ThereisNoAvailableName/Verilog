//testbench for find.v
`timescale 1ns/1ps
`define T_CLK 10

module tb_find;
  
  reg clk, n_rst, din;
  wire alarm;
  
  
  initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    @(negedge clk) n_rst = 1'b1;
  end
  
  always #(`T_CLK/2) clk = ~clk;
  
  
  initial begin
    din = 1'b1;
    #(`T_CLK * 1.3);
    
    din = 1'b1;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b1;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b1;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b1;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b1;
    #(`T_CLK);
    din = 1'b1;
    #(`T_CLK);
    din = 1'b1;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b1;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b0;
    #(`T_CLK);
    din = 1'b1;
    #(`T_CLK);
    
    #(`T_CLK * 2);
    $stop;
  end
  
  
  find u_find(
    .clk(clk),
    .n_rst(n_rst),
    .din(din),
    .alarm(alarm)
    );
  
endmodule
  
