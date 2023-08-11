//4bit up down counter
//1:up  0:down
`timescale 1ns/1ps

module counter(
  clk,
  n_rst,
  up_down,
  cnt
  );
  
  input clk, n_rst, up_down;
  output [3:0] cnt;
  reg [3:0] cnt;
  
  reg [2:0] c_state, n_state;
  
  parameter IDLE = 3'h0,  //reset
            SET_U = 3'h1,  //set for UP
            SET_D = 3'h2,  //set for DOWN
            UP = 3'h3,  //UP count
            DOWN = 3'h4;  //DOWN count
  
  
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      c_state <= IDLE;
    else
      c_state <= n_state;
  end
  
  
  //for n_state
  always @(c_state or n_state or up_down or cnt) begin
    case(c_state)
      IDLE : n_state = (up_down)? SET_U : SET_D;
      SET_U : n_state = UP;
      SET_D : n_state = DOWN;
      UP : n_state = (cnt != 4'hf)? UP : IDLE;
      DOWN : n_state = (cnt != 4'h0)? DOWN : IDLE;
      default : n_state = IDLE;
    endcase
  end
  
  
  //for cnt
  always @(posedge clk or negedge n_rst) begin
    case(c_state) 
      IDLE : cnt <= 4'h0;
      SET_U : cnt <= 4'h0;
      SET_D : cnt <= 4'hf;
      UP : cnt <= (cnt + 4'h1);
      DOWN : cnt <= (cnt - 4'h1);
      default : cnt <= 4'h0;
    endcase
  end
  
endmodule
