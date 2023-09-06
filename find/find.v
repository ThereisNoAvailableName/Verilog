//find 1101
`timescale 1ns/1ps

module find(
  clk,
  n_rst,
  din,
  alarm
  );
  
  input clk, n_rst, din;
  output alarm;
  
  
  parameter IDLE = 3'h0,
            S1 = 3'h1,
            S2 = 3'h2,
            S3 = 3'h3,
            S4 = 3'h4;
  
  reg [2:0] n_state, c_state;
  
  
  //c_state
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) 
      c_state <= IDLE;
    else
      c_state <= n_state;
  end
  
  
  //n_state
  always @(n_state or c_state or din) begin
    case(c_state)
      IDLE : n_state = (din == 1'b1)? S1 : IDLE;
      S1 : n_state = (din == 1'b1)? S2 : IDLE;
      S2 : n_state = (din == 1'b0)? S3 : S2;
      S3 : n_state = (din == 1'b1)? S4 : IDLE;
      S4 : n_state = IDLE;
      default : n_state = IDLE;
    endcase
  end
  
  
  //alarm
  assign alarm = (c_state == S4)? 1'b1 : 1'b0;
  
endmodule
